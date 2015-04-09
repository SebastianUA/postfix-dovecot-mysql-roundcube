#!/bin/sh

apt-get install git wget 
cd /usr/local/src && git clone https://github.com/SebastianUA/postfix-dovecot-mysql-roundcube.git

#moving to etc
mv postfix-dovecot-mysql-roundcube/dovecot /etc/
mv postfix-dovecot-mysql-roundcube/httpd /etc/
mv postfix-dovecot-mysql-roundcube/postfix /etc/
mv postfix-dovecot-mysql-roundcube/mysql/* /etc/

#moving to /var/www/
mv postfix-dovecot-mysql-roundcube/postfix/roundcubemail /var/www/
mv postfix-dovecot-mysql-roundcube/postfix/iredadmin /var/www/


