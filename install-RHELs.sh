#!/bin/sh

#delete sendmail:
yum remove sendmail

#Install some utilits: 
yum install mlocate bind-utils telnet mailx sharutils

#install if ! type -path:
if ! type -path "wget" > /dev/null 2>&1; then yum install wget -y; fi
if ! type -path "git" > /dev/null 2>&1; then yum install git -y; fi
if ! type -path "httpd" > /dev/null 2>&1; then yum install httpd mod_auth_mysql mod_dnssd mod_ssl mod_wsgi -y; fi
if ! type -path "php" > /dev/null 2>&1; then yum install php php-imap php-mysql php-mbstring php-xml php-pdo php-mcrypt php-intl -y; fi
if ! type -path "mysql" > /dev/null 2>&1; then yum install mysql mysql-server -y; mysql_secure_installation; fi
if ! type -path "postfix" > /dev/null 2>&1; then yum install postfix -y; fi
if ! type -path "dovecot" > /dev/null 2>&1; then yum install dovecot dovecot-mysql dovecot-pigeonhole -y; fi

#download clone
cd /usr/local/src && git clone https://github.com/SebastianUA/postfix-dovecot-mysql-roundcube.git

#move files to etc
#rm -rf /etc/dovecot
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/dovecot /etc/
#rm -rf /etc/httpd
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/httpd /etc/
#rm -rf /etc/postfix
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/postfix /etc/
#rm -rf /etc/my.cnf
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/mysql/* /etc/

#move certs to etc
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/certs_and_keys/certs/* /etc/pki/tls/certs/
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/certs_and_keys/private/* /etc/pki/tls/private/

#move roundcubemail iredadmin and to /var/www/
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/icons /var/www/
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/roundcubemail-1.0.4 /var/www/
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/iRedAdmin-0.4.1 /var/www/
chown -R iredadmin:iredadmin /var/www/iRedAdmin-0.4.1

#create links for  roundcubemail and iRedAdmin
#ln -s {target-filename} {symbolic-filename}
mkdir -p /var/www/roundcubemail
ls -s /var/www/roundcubemail-1.0.4 /var/www/roundcubemail
mkdir -p /var/www/iredadmin
ls -s /var/www/iRedAdmin-0.4.1 /var/www/iredadmin

#create DBs 
mysql -uroot -p << EOF

CREATE database iredadmin;
GRANT ALL ON iredadmin.* TO iredadmin@localhost IDENTIFIED BY 'iredadmin_pw';
CREATE database roundcube;
GRANT ALL ON roundcube.* TO roundcube@localhost IDENTIFIED BY 'roundcube_pw';
CREATE database vmail;
GRANT ALL ON vmail.* TO vmail@localhost IDENTIFIED BY 'vmail_pw';
GRANT ALL ON vmail.* TO vmailadmin@localhost IDENTIFIED BY 'vmailadmin_pw';
exit;
EOF

#restore DBs
mysql -uroot -p iredadmin < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/iredadmin.sql
mysql -uroot -p roundcube < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/roundcubemail.sql
mysql -uroot -p vmail < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/vmail.sql

# create new users (iredadmin and vmail):
useradd -M  -s /sbin/nologin -U iredadmin
useradd -M  -s /sbin/nologin -U vmail

#create new admin user 


#add logs and pid
#mkdir -p /etc/httpd/logs
#touch /etc/httpd/logs/error_log
#mkdir -p /etc/httpd/run
#touch /etc/httpd/run/httpd.pid


#restart all services
/etc/init.d/mysqld restart
service httpd restart
service postfix restart
service dovecot restart

#remove trash
rm -rf /usr/local/src/postfix-dovecot-mysql-roundcube
echo "=====================================================";
echo "========================DONE!========================";
echo "=====================================================";
