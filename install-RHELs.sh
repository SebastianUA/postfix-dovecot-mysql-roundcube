#!/bin/sh

#delete sendmail:
yum remove sendmail

#Install some utilits: 
yum install mlocate bind-utils telnet mailx sharutils

#install if ! type -path:
if ! type -path "wget" > /dev/null 2>&1; then yum install wget -y; fi
if ! type -path "git" > /dev/null 2>&1; then yum install git -y; fi
if ! type -path "httpd" > /dev/null 2>&1; then yum install httpd -y; fi
if ! type -path "php" > /dev/null 2>&1; then yum install php php-imap php-mysql php-mbstring php-xml php-pdo php-mcrypt php-intl -y; fi
if ! type -path "mysql" > /dev/null 2>&1; then yum install mysql -y; mysql_secure_installation; fi
if ! type -path "postfix" > /dev/null 2>&1; then yum install postfix -y; fi
if ! type -path "dovecot" > /dev/null 2>&1; then yum install dovecot dovecot-mysql -y; fi

#download clone
cd /usr/local/src && git clone https://github.com/SebastianUA/postfix-dovecot-mysql-roundcube.git

#moving to etc
rm -rf /etc/dovecot
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/dovecot /etc/
rm -rf /etc/httpd
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/httpd /etc/
rm -rf /etc/postfix
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/postfix /etc/
rm -rf /etc/my.cnf
mv -f /usr/local/src/postfix-dovecot-mysql-roundcube/mysql/* /etc/

#moving to /var/www/
mv -f postfix-dovecot-mysql-roundcube/postfix/roundcubemail /var/www/
mv -f postfix-dovecot-mysql-roundcube/postfix/iredadmin /var/www/

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
service mysqld restart

#restore DBs
mysql -uroot -p iredadmin < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/iredadmin.sql
mysql -uroot -p roundcube < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/roundcubemail.sql
mysql -uroot -p vmail < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/vmail.sql

#create new admin user 

#remove trash
rm -rf /usr/local/src/postfix-dovecot-mysql-roundcube
echo "================================================";
echo "DONE!";
echo "================================================";
