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

CREATE database iredadmin;
GRANT ALL ON iredadmin.* TO iredadmin@localhost IDENTIFIED BY 'iredadmin_pw’;
CREATE database roundcube;
GRANT ALL ON roundcube.* TO roundcube@localhost IDENTIFIED BY 'roundcube_pw';
CREATE database vmail;
GRANT ALL ON vmail.* TO vmail@localhost IDENTIFIED BY 'vmail'_pw;
GRANT ALL ON vmail.* TO vmailadmin@localhost IDENTIFIED BY 'vmailadmin_pw';
exit;


#remove trash
rm -rf /usr/local/src/postfix-dovecot-mysql-roundcube
echo "================================================";
echo "DONE!";
echo "================================================";
