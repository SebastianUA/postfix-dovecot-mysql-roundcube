# Author: Zhang Huangbin <zhb@iredmail.org>

import time
import ldap
import web
from socket import getfqdn
from urllib import urlencode
import settings
from libs import __url_latest_ose__, __version_ose__
from libs import iredutils, languages
from libs.ldaplib import auth, decorators, admin as adminlib, ldaputils


session = web.config.get('_session')


class Login:
    def GET(self):
        if session.get('logged') is False:
            i = web.input(_unicode=False)

            # Show login page.
            return web.render('login.html',
                              languagemaps=languages.get_language_maps(),
                              webmaster=session.get('webmaster'),
                              msg=i.get('msg'))
        else:
            raise web.seeother('/dashboard')

    def POST(self):
        # Get username, password.
        i = web.input(_unicode=False)

        username = web.safestr(i.get('username', '').strip()).lower()
        password = i.get('password', '').strip()
        save_pass = web.safestr(i.get('save_pass', 'no').strip())

        if not iredutils.is_email(username):
            raise web.seeother('/login?msg=INVALID_USERNAME')

        if not password:
            raise web.seeother('/login?msg=EMPTY_PASSWORD')

        # Get LDAP URI.
        uri = settings.ldap_uri

        # Verify bind_dn & bind_pw.
        try:
            # Detect STARTTLS support.
            if uri.startswith('ldaps://'):
                starttls = True
            else:
                starttls = False

            # Set necessary option for STARTTLS.
            if starttls:
                ldap.set_option(ldap.OPT_X_TLS_REQUIRE_CERT, ldap.OPT_X_TLS_NEVER)

            # Initialize connection.
            conn = ldap.initialize(uri)

            # Set LDAP protocol version: LDAP v3.
            conn.set_option(ldap.OPT_PROTOCOL_VERSION, ldap.VERSION3)

            if starttls:
                conn.set_option(ldap.OPT_X_TLS, ldap.OPT_X_TLS_DEMAND)

            # synchronous bind.
            conn.bind_s(settings.ldap_bind_dn, settings.ldap_bind_password)
            conn.unbind_s()
        except (ldap.INVALID_CREDENTIALS):
            raise web.seeother('/login?msg=vmailadmin_INVALID_CREDENTIALS')
        except Exception, e:
            raise web.seeother('/login?msg=%s' % web.safestr(e))

        # Check whether it's a mail user
        dn_user = ldaputils.convert_keyword_to_dn(username, accountType='user')
        qr_user_auth = auth.Auth(uri=uri, dn=dn_user, password=password)

        qr_admin_auth = (False, 'INVALID_CREDENTIALS')
        if not qr_user_auth[0]:
            # Verify admin account under 'o=domainAdmins'.
            dn_admin = ldaputils.convert_keyword_to_dn(username, accountType='admin')
            qr_admin_auth = auth.Auth(uri=uri, dn=dn_admin, password=password)

            if not qr_admin_auth[0]:
                session['failed_times'] += 1
                web.logger(msg="Login failed.", admin=username, event='login', loglevel='error')
                raise web.seeother('/login?msg=INVALID_CREDENTIALS')

        if qr_admin_auth[0] or qr_user_auth[0]:
            session['username'] = username
            session['logged'] = True

            # Read preferred language from LDAP
            if qr_admin_auth[0] is True:
                adminLib = adminlib.Admin()
                adminProfile = adminLib.profile(username, attributes=['preferredLanguage'])
                if adminProfile[0] is True:
                    dn, entry = adminProfile[1][0]
                    lang = entry.get('preferredLanguage', [settings.default_language])[0]
                    session['lang'] = lang

            if qr_user_auth[0] is True:
                session['isMailUser'] = True

            web.config.session_parameters['cookie_name'] = 'iRedAdmin-Pro'
            # Session expire when client ip was changed.
            web.config.session_parameters['ignore_change_ip'] = False
            # Don't ignore session expiration.
            web.config.session_parameters['ignore_expiry'] = False

            if save_pass == 'yes':
                # Session timeout (in seconds).
                web.config.session_parameters['timeout'] = 86400    # 24 hours
            else:
                # Expire session when browser closed.
                web.config.session_parameters['timeout'] = 600      # 10 minutes

            web.logger(msg="Login success", event='login',)

            # Save selected language
            selected_language = str(i.get('lang', '')).strip()
            if selected_language != web.ctx.lang and \
               selected_language in languages.get_language_maps():
                session['lang'] = selected_language

            raise web.seeother('/dashboard/checknew')
        else:
            session['failed_times'] += 1
            web.logger(msg="Login failed.", admin=username, event='login', loglevel='error',)
            raise web.seeother('/login?msg=%s' % qr_admin_auth[1])


class Logout:
    @decorators.require_login
    def GET(self):
        session.kill()
        raise web.seeother('/login')


class Dashboard:
    @decorators.require_login
    def GET(self, checknew=False):
        if checknew:
            checknew = True

        # Get network interface related infomation.
        netif_data = {}
        try:
            import netifaces
            ifaces = netifaces.interfaces()
            for iface in ifaces:
                addr = netifaces.ifaddresses(iface)
                if netifaces.AF_INET in addr.keys():
                    data = addr[netifaces.AF_INET][0]
                    try:
                        netif_data[iface] = {'addr': data['addr'], 'netmask': data['netmask'], }
                    except Exception:
                        pass
        except Exception:
            pass

        # Check new version.
        newVersionInfo = (None, )
        if session.get('domainGlobalAdmin') is True and checknew is True:
            try:
                curdate = time.strftime('%Y-%m-%d')
                vars = dict(date=curdate)

                r = web.admindb.select('updatelog', vars=vars, where='date >= $date',)
                if len(r) == 0:
                    urlInfo = {
                        'v': __version_ose__,
                        'lang': settings.default_language,
                        'host': getfqdn(),
                        'backend': settings.backend,
                    }

                    url = __url_latest_ose__ + '?' + urlencode(urlInfo)
                    newVersionInfo = iredutils.getNewVersion(url)

                    # Always remove all old records, just keep the last one.
                    web.admindb.delete('updatelog', vars=vars, where='date < $date',)

                    # Insert updating date.
                    web.admindb.insert('updatelog', date=curdate,)
            except Exception, e:
                newVersionInfo = (False, str(e))

        return web.render(
            'dashboard.html',
            version=__version_ose__,
            hostname=getfqdn(),
            uptime=iredutils.get_server_uptime(),
            loadavg=iredutils.get_system_load_average(),
            netif_data=netif_data,
            newVersionInfo=newVersionInfo,
        )
