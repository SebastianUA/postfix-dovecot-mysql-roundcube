#!/bin/sh
#update OS
yum update

#delete sendmail:
yum remove sendmail

#Install some utilits: 
yum install mlocate bind-utils telnet mailx sharutils 

#install uwsgi
 yum install python-devel gcc python-setuptools python python-pip mod_wsgi
 pip install virtualenv

#install mod_pyton
yum install mod_pyton
echo "Confirm that mod_python connected to Apache";
apachectl -M 2>&1 | grep python


#install if ! type -path:
if ! type -path "wget" > /dev/null 2>&1; then yum install wget -y; else echo "wget INSTALLED"; fi
if ! type -path "git" > /dev/null 2>&1; then yum install git -y;  else echo "git INSTALLED"; fi
if ! type -path "httpd" > /dev/null 2>&1; then yum install httpd mod_auth_mysql mod_dnssd mod_ssl -y;  else echo "HTTPD INSTALLED"; fi
if ! type -path "php" > /dev/null 2>&1; then yum install php php-imap php-mysql php-mbstring php-xml php-pdo php-mcrypt php-intl -y;  else echo "PHP INSTALLED"; fi
if ! type -path "mysql" > /dev/null 2>&1; then yum install mysql mysql-server -y; service mysqld restart; mysql_secure_installation; else echo "MYSQL INSTALLED";fi
#  service mysql restart; mysql_secure_installation;
if ! type -path "postfix" > /dev/null 2>&1; then yum install postfix cronie -y;  else echo "postfix INSTALLED"; fi
if ! type -path "dovecot" > /dev/null 2>&1; then yum install dovecot dovecot-mysql dovecot-pigeonhole -y;  else echo "dovecot INSTALLED"; fi

yum install mod_auth_mysql mod_dnssd mod_ssl php-imap php-mysql php-mbstring php-xml php-pdo php-mcrypt php-intl

#update
yum update postfix dovecot
echo "===========================";
echo "=======Copy the files======";
echo "===========================";
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

echo "===========================";
echo "====Create databases====";
echo "===========================";
#create DBs 
service mysqld restart
mysql -uroot -p << EOF
CREATE database iredadmin;
GRANT ALL ON iredadmin.* TO iredadmin@localhost IDENTIFIED BY 'Zv5EzKG3VXkwH2ASWh3JyKGJJuB2M6';
CREATE database roundcubemail;
GRANT ALL ON roundcubemail.* TO roundcube@localhost IDENTIFIED BY '5CxgEu109zOEdRIHTbU6WkQvkxmRHm';
CREATE database vmail;
GRANT ALL ON vmail.* TO vmail@localhost IDENTIFIED BY 'BKG9DBgycYFbsXTH8oU9q7sLUHRCxM';
GRANT ALL ON vmail.* TO vmailadmin@localhost IDENTIFIED BY 'BGKeeM8sm3s0KuLg2MmFJxLxGydkhc';
flush privileges;
exit;
EOF

#restore  DBs with some users
mysql -uroot -p iredadmin < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/iredadmin-full.sql
mysql -uroot -p roundcubemail < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/roundcubemail-full.sql
mysql -uroot -p vmail < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/vmail-full.sql

#restore just structure of DBs and add some users
#mysql -uroot -p iredadmin < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/iredadmin-struct..sql
#mysql -uroot -p roundcubemail < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/roundcubemail-struct..sql
#mysql -uroot -p vmail < /usr/local/src/postfix-dovecot-mysql-roundcube/Structures_for_DBs/vmail-struct..sql

#create new users postmaster@test.com.local with the password QWERTY##12|34 and the second user test666@test.com.local and his pw is QWERTY####12|34
#mysql -uroot -p << EOF
#use vmail;
#INSERT INTO `alias` VALUES ('postmaster@test.com.local','postmaster@test.com.local','',NULL,'','test.com.local',0,'2015-04-08 13:54:18','0000-00-00 00:00:00','9999-12-31 00:00:00',1),('test666@test.com.local','test666@test.com.local','',NULL,'','test.com.local',0,'2015-04-08 11:08:42','0000-00-00 00:00:00','9999-12-31 00:00:00',1);
#INSERT INTO `domain` VALUES ('test.com.local',NULL,NULL,0,0,0,0,'dovecot',0,'default_user_quota:1024;','2015-04-08 13:54:18','0000-00-00 00:00:00','9999-12-31 00:00:00',1);
#INSERT INTO `domain_admins` VALUES ('postmaster@test.com.local','ALL','2015-04-08 13:54:18','0000-00-00 00:00:00','9999-12-31 00:00:00',1);
#INSERT INTO `mailbox` VALUES ('postmaster@test.com.local','{SSHA512}b3931f1983861e56a56c114e8eb2f20ab9a3bb4edd0b9728b0b49aa8dd4891b7bed9a8075da022e0d3ee5d67073db1a1b9ab167a87f0e04ec86d63ecc4f94d0f','postmaster','en_US','/var/vmail','vmail1','test.com.local/p/o/s/postmaster-2015.04.08.13.26.39/',100,'test.com.local','','','normal','',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,'0000-00-00 00:00:00',0,'',NULL,NULL,NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','2015-04-08 13:54:18','0000-00-00 00:00:00','9999-12-31 00:00:00',1,''),('test666@test.com.local','{SSHA512}b3931f1983861e56a56c114e8eb2f20ab9a3bb4edd0b9728b0b49aa8dd4891b7bed9a8075da022e0d3ee5d67073db1a1b9ab167a87f0e04ec86d63ecc4f94d0f','test666','en_US','/var/vmail','vmail1','test.com.local/t/e/s/test666-2015.04.08.14.08.42/',154,'test.com.local','','','normal','',0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,'0000-00-00 00:00:00',0,'',NULL,NULL,NULL,NULL,NULL,NULL,'0000-00-00 00:00:00','2015-04-08 11:08:42','0000-00-00 00:00:00','9999-12-31 00:00:00',1,'test666');
#INSERT INTO `used_quota` VALUES ('test666@test.com.local',1055,2,'test.com.local');
#use roundcubemail;
#INSERT INTO `users` VALUES (1,'postmaster@test.com.local','127.0.0.1','2015-04-08 14:00:29','2015-04-08 14:00:29','en_US',NULL),(2,'test666@test.com.local','127.0.0.1','2015-04-08 14:12:26','2015-04-08 14:31:37','en_US',NULL);
#INSERT INTO `identities` VALUES (1,1,'2015-04-08 14:00:29',0,1,'','','postmaster@test.com.local','','',NULL,0),(2,2,'2015-04-08 14:12:26',0,1,'','','test666@test.com.local','','',NULL,0);
#exit;
#EOF

#flush privileges
mysql -uroot -p << EOF
flush privileges;
exit;
EOF

echo "===========================";
echo "=====Add some users=====";
echo "===========================";
# create new users (iredadmin and vmail):
useradd  -s /sbin/nologin -U iredadmin
useradd -M  -s /sbin/nologin -u 2000 vmail #useradd -M  -s /sbin/nologin -U vmail -u 2000 -g 2000 # need add UID -> 2000:2000
useradd -M  -s /sbin/nologin -U roundcubemail
chown -R iredadmin:iredadmin /var/www/iRedAdmin-0.4.1
chown -R iredadmin:iredadmin /var/www/html/iredadmin
chown -R roundcubemail:roundcubemail /var/www/html/roundcubemail 
chown -R roundcubemail:roundcubemail /var/www/roundcubemail-1.0.4
chmod 640 /etc/postfix/mysql/*

#Add rules to firewall

echo "===========================";
echo "Add services to autostart";
echo "===========================";
#add all services to autostart
chkconfig postfix on
chkconfig dovecot on
chkconfig httpd on
chkconfig mysqld on

echo "===========================";
echo "Restart all services";
echo "===========================";
#restart all services
/etc/init.d/mysqld restart
service httpd restart
service postfix restart
service dovecot restart

echo "===========================";
echo "Set up permissions";
echo "===========================";
#chmod all folders and the files
find /var/www/ -type f -exec chmod 644 {} \;
find /var/www/ -type d -exec chmod 755 {} \;

# chown + chmod
#
# Dovecot
chmod +r /etc/dovecot/dovecot-master-users
chown -R dovecot:dovecot /etc/dovecot/dovecot-master-users
chown -R dovecot:dovecot /etc/dovecot/dovecot-share-folder.conf
chown -R dovecot:dovecot /etc/dovecot/dovecot-used-quota.conf
#
# Postfix
chown -R .postfix /etc/postfix/mysql/*

# vmail
chown -R vmail:vmail /var/log/dovecot.log
touch /var/log/dovecot-lmtp.log
chown -R vmail:vmail /var/log/dovecot-lmtp.log
mkdir -p /var/vmail/
chown -R vmail:vmail /var/vmail/
chmod -R 700 /var/vmail/

# send test email
#ps ax | mail -s test test_user@localhost.test.local
#ps ax | mail -s test postmaster@localhost.test.local
#ps ax | mail -s test test@test.com.local

#
#remove trash
read -p 'Would you like to delete the GIT repo from server (Yes/No/exit/q)? ' delete_git_repo
case ${delete_git_repo} in
    Yes|Y|y|YES) {
                  rm -rf /usr/local/src/postfix-dovecot-mysql-roundcube
                  };;
    Not|not|NOT|No|NO|N|n) {
                            echo "GIT Repository has not been removed from server. SEE it on folder /usr/local/src/";
                            };;              
    exit|e) exit 1     ;;
    q|quit) exit 1     ;;
     *) echo "error: not correct variable, try to start this script again";;
 esac
echo "=====================================================";
echo "========================DONE!========================";
echo "=====================================================";


echo "Would you like to set up web interface for mail?";
echo "---------------------------------------------------";
echo "Squirrelmail";
echo "Roundcube";
echo "Horde";
echo "exit= exit";
echo "q= quit";
echo "----------------------------------------------------";


read -p 'Please, enter check variable (S/R/H/exit/q): ' CHECK
case ${CHECK} in
    Squirrelmail|squirrelmail|s|S) {
                       echo "Squirrelmail: $CHECK"      
		                                                                                                             
                        echo "-------------------------"                                                
                        echo "Done."                                                                    
                        echo "-------------------------" 
                    };;
    Roundcube|roundcube|r|R) { 
                         echo "Roundcube: $CHECK"
                       
                          echo "-------------------------"                                                
                          echo "Done."                                                                    
                          echo "-------------------------"    
                       };;
      Horde|horde|h|H) { 
                         echo "Horde: $CHECK"
                       
                          echo "-------------------------"                                                
                          echo "Done."                                                                    
                          echo "-------------------------"    
                       };;                  
    exit|e) exit 1     ;;
    q|quit) exit 1     ;;
     *) echo "error: not correct variable, try to start this script again";;
 esac
 
echo "=====================================================";
echo "======================FINISHED!======================";
echo "=====================================================";



