#!/bin/sh
#update OS
yum update

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
/bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/dovecot/* /etc/dovecot/
/bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/httpd/* /etc/httpd/
/bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/postfix/* /etc/postfix/
/bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/mysql/* /etc/

#move certs to etc
/bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/certs_and_keys/certs/* /etc/pki/tls/certs/
/bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/certs_and_keys/private/* /etc/pki/tls/private/

#move roundcubemail iredadmin and to /var/www/
/bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/icons /var/www/
/bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/roundcubemail-1.0.4 /var/www/
/bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/iRedAdmin-0.4.1 /var/www/

#create links for  roundcubemail and iRedAdmin
#ln -s {target-filename} {symbolic-filename}
ln -s /var/www/roundcubemail-1.0.4 /var/www/html/roundcubemail
ln -s /var/www/iRedAdmin-0.4.1 /var/www/html/iredadmin

#create DBs 
service mysqld restart
mysql -uroot -p << EOF

CREATE database iredadmin;
GRANT ALL ON iredadmin.* TO iredadmin@localhost IDENTIFIED BY 'iredadmin_pw';
CREATE database roundcubemail;
GRANT ALL ON roundcubemail.* TO roundcube@localhost IDENTIFIED BY 'roundcube_pw';
CREATE database vmail;
GRANT ALL ON vmail.* TO vmail@localhost IDENTIFIED BY 'BKG9DBgycYFbsXTH8oU9q7sLUHRCxM';
GRANT ALL ON vmail.* TO vmailadmin@localhost IDENTIFIED BY 'BGKeeM8sm3s0KuLg2MmFJxLxGydkhc';
flush privileges;
exit;
EOF

#restore DBs
mysql -uroot -p iredadmin < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/iredadmin.sql
mysql -uroot -p roundcubemail < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/roundcubemail.sql
mysql -uroot -p vmail < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/vmail.sql

#create new users postmaster@test.com.local with the password and the second user test666@test.com.local and his pw is QWERTY####12|34
mysql -uroot -p << EOF
use vmail;
INSERT INTO `alias` VALUES ('postmaster@test.com.local','postmaster@test.com.local','',NULL,'','test.com.local',0,'2015-04-08 13:54:18','0000-00-00 00:00:00','9999-12-31 00:00:00',1),('test666@test.com.local','test666@test.com.local','',NULL,'','test.com.local',0,'2015-04-08 11:08:42','0000-00-00 00:00:00','9999-12-31 00:00:00',1);
INSERT INTO `domain` VALUES ('test.com.local',NULL,NULL,0,0,0,0,'dovecot',0,'default_user_quota:1024;','2015-04-08 13:54:18','0000-00-00 00:00:00','9999-12-31 00:00:00',1);
INSERT INTO `domain_admins` VALUES ('postmaster@test.com.local','ALL','2015-04-08 13:54:18','0000-00-00 00:00:00','9999-12-31 00:00:00',1);
INSERT INTO `mailbox` VALUES ('postmaster@test.com.local','{SSHA512}Tl1qk/rBv+0ei0StJY29VXYpDDURhEZg5I0Wl1PVnB8KYp0RAsYO+VrmehjvIGozNSyiVzOPKKk2KUs1RKcfJmnnbz7CLyZj','postmaster','en_US','/var/vmail','vmail1','test.com.local/p/o/s/postmaster-2015.04.08.13.26.39/',100,'test.com.local','','','normal','',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,'0000-00-00 00:00:00',0,'',NULL,NULL,NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','2015-04-08 13:54:18','0000-00-00 00:00:00','9999-12-31 00:00:00',1,''),('test666@test.com.local','{SSHA512}ZqSF1lUd3G99EmaoDcQXcVEV16TwPUrK60BgrEIsJxfoi3c5v/TNeEyxlwsn3SX/ooxVXHE6XVOkj5WD5bzDhUcB3GgAAXs5','test666','en_US','/var/vmail','vmail1','test.com.local/t/e/s/test666-2015.04.08.14.08.42/',154,'test.com.local','','','normal','',0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,'0000-00-00 00:00:00',0,'',NULL,NULL,NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','2015-04-08 11:08:42','0000-00-00 00:00:00','9999-12-31 00:00:00',1,'test666');
INSERT INTO `used_quota` VALUES ('test666@test.com.local',1055,2,'test.com.local');
use roundcubemail;
INSERT INTO `users` VALUES (1,'postmaster@test.com.local','127.0.0.1','2015-04-08 14:00:29','2015-04-08 14:00:29','en_US',NULL),(2,'test666@test.com.local','127.0.0.1','2015-04-08 14:12:26','2015-04-08 14:31:37','en_US',NULL);
INSERT INTO `identities` VALUES (1,1,'2015-04-08 14:00:29',0,1,'','','postmaster@test.com.local','','',NULL,0),(2,2,'2015-04-08 14:12:26',0,1,'','','test666@test.com.local','','',NULL,0);
exit;
EOF

# create new users (iredadmin and vmail):
useradd  -s /sbin/nologin -U iredadmin
useradd -M  -s /sbin/nologin -U vmail
useradd -M  -s /sbin/nologin -U roundcubemail
chown -R iredadmin:iredadmin /var/www/iRedAdmin-0.4.1
chown -R roundcubemail:roundcubemail /var/www/roundcubemail 
chown -R roundcubemail:roundcubemail /var/www/roundcubemail-1.0.4
chmod 644 /etc/postfix/mysql/*
#chmod 644 /etc/postfix/mysql/virtual_alias_maps.cf
#chmod 644 /etc/postfix/mysql/relay_domains.cf
#chmod 644 /etc/postfix/mysql/virtual_alias_maps.cf

#Add rules to firewall

#add all services to autostart
chkconfig postfix on
chkconfig dovecot on
chkconfig httpd on
chkconfig mysqld on

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
