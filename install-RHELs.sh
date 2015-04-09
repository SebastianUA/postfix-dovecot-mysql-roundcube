#!/bin/sh

#delete sendmail:
yum remove sendmail

#Install some utilits: 
yum install mlocate bind-utils telnet mailx sharutils
if ! type -path "wget" > /dev/null 2>&1; then yum install wget -y; fi
if ! type -path "git" > /dev/null 2>&1; then yum install git -y; fi
if ! type -path "httpd" > /dev/null 2>&1; then yum install httpd -y; fi
if ! type -path "php" > /dev/null 2>&1; then yum install php -y; fi
if ! type -path "mysql" > /dev/null 2>&1; then yum install mysql -y; fi
if ! type -path "postfix" > /dev/null 2>&1; then yum install postfix -y; fi
if ! type -path "dovecot" > /dev/null 2>&1; then yum install dovecot dovecot-mysql -y; fi


cd /usr/local/src && git clone https://github.com/SebastianUA/postfix-dovecot-mysql-roundcube.git

#moving to etc
mv postfix-dovecot-mysql-roundcube/dovecot /etc/
mv postfix-dovecot-mysql-roundcube/httpd /etc/
mv postfix-dovecot-mysql-roundcube/postfix /etc/
mv postfix-dovecot-mysql-roundcube/mysql/* /etc/

#moving to /var/www/
mv postfix-dovecot-mysql-roundcube/postfix/roundcubemail /var/www/
mv postfix-dovecot-mysql-roundcube/postfix/iredadmin /var/www/


#restore DBs
mysql -uroot -p



