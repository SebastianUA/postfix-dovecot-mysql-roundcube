#!/bin/sh
#update OS
yum update

#delete sendmail:
yum remove sendmail

#Install some utilits: 
yum install mlocate bind-utils telnet mailx sharutils unzip

#install uwsgi
 yum install python-devel gcc python-setuptools python python-pip mod_wsgi
 pip install virtualenv

#install mod_pyton
yum install mod_python python-webpy MySQL-python
echo "Confirm that mod_python connected to Apache";
echo "---------------------------------------------------------------------------------";
apachectl -M 2>&1 | grep python;
echo "---------------------------------------------------------------------------------";

#install if ! type -path:
if ! type -path "wget" > /dev/null 2>&1; then yum install wget -y; else echo "wget INSTALLED"; fi
if ! type -path "git" > /dev/null 2>&1; then yum install git -y; else echo "git INSTALLED"; fi
if ! type -path "httpd" > /dev/null 2>&1; then yum install httpd mod_auth_mysql mod_dnssd mod_ssl -y; else echo "HTTPD INSTALLED"; fi
if ! type -path "php" > /dev/null 2>&1; then yum install php php-imap php-mysql php-mbstring php-xml php-pdo php-mcrypt php-intl -y; else echo "PHP INSTALLED"; fi
if ! type -path "mysql" > /dev/null 2>&1; then yum install mysql mysql-server -y; else echo "MYSQL INSTALLED";fi
#  service mysql restart; mysql_secure_installation;
if ! type -path "postfix" > /dev/null 2>&1; then yum install postfix cronie -y;  else echo "postfix INSTALLED"; fi
if ! type -path "dovecot" > /dev/null 2>&1; then yum install dovecot dovecot-mysql dovecot-pigeonhole -y;  else echo "dovecot INSTALLED"; fi

yum install mod_auth_mysql mod_dnssd mod_ssl php-imap php-mysql php-mbstring php-xml php-pdo php-mcrypt php-intl -y

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
#ln -s /var/www/iRedAdmin-0.4.1 /var/www/iredadmin
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
service iptables stop

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
read -p 'Would you like to install PostfixAdmin (Yes/No/quit)? ' install_PostfixAdmin
case ${install_PostfixAdmin} in
    Yes|Y|y|YES) {
                  echo "---------------------------------------------------------------------------------";
                  mysql -uroot -p << EOF
                  use vmail;
	          CREATE TABLE IF NOT EXISTS log (TIMESTAMP DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00', username VARCHAR(255) NOT NULL DEFAULT '', domain VARCHAR(255) NOT NULL DEFAULT '', action VARCHAR(255) NOT NULL DEFAULT '', data VARCHAR(255) NOT NULL DEFAULT '', KEY TIMESTAMP (TIMESTAMP)) ENGINE=MyISAM;
		  CREATE TABLE IF NOT EXISTS vacation (email VARCHAR(255) NOT NULL DEFAULT '', subject VARCHAR(255) NOT NULL DEFAULT '', body TEXT NOT NULL, cache TEXT NOT NULL, domain VARCHAR(255) NOT NULL DEFAULT '', created DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00', modified DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00', active TINYINT(4) NOT NULL DEFAULT '1', PRIMARY KEY (email), KEY email (email)) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
		  CREATE TABLE IF NOT EXISTS vacation_notification (on_vacation VARCHAR(255) NOT NULL, notified VARCHAR(255) NOT NULL, notified_at TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT vacation_notification_pkey PRIMARY KEY(on_vacation, notified), FOREIGN KEY (on_vacation) REFERENCES vacation(email) ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
		  flush privileges;
                  exit;
                  EOF
                  
                  # download postfixadmin and setup it
                  cd /usr/local/src/ && wget http://garr.dl.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-2.92/postfixadmin-2.92.tar.gz
                  tar zxf postfixadmin-*.tar.gz -C /var/www/     
		  ln -s /var/www/postfixadmin-* /var/www/postfixadmin        
		  chown -R root:root /var/www/postfixadmin        
		  chmod -R 755 /var/www/postfixadmin
		  #mv /var/www/postfixadmin/setup.php /var/www/postfixadmin/setup.php.save
		  echo '' > motd.txt;
		  echo '' > motd-users.txt;
		  
		  #copy config
		  /bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/postfixadmin/config.local.php /var/www/postfixadmin/
		  /bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/postfixadmin/postfixadmin.conf /etc/httpd/conf.d/
		  
		  # Add below lines before </VirtualHost>
		  echo "Alias /postfixadmin "/var/www/postfixadmin/"" > /etc/httpd/conf.d/ssl.conf
		  #sed -i 's/</VirtualHost>/ Alias /postfixadmin "/var/www/postfixadmin/" </VirtualHost>/' /etc/httpd/conf.d/ssl.conf
		  chmod 777 /var/www/postfixadmin/templates_c
		  service httpd restart;
                  echo "---------------------------------------------------------------------------------";
                  # http://www.iredmail.org/wiki/index.php?title=Addition/Install.PostfixAdmin.For.MySQL.Backend
                  };;
    Not|not|NOT|No|NO|N|n) {
    			    echo "----------------------------------------------------------------";
                            echo "PostfixAdmin has not been installed. Installation was cancelled!";
                            echo "----------------------------------------------------------------";
                            };;              
    q|quit) exit 1     ;;
     *) echo "error: not correct variable, try to start this script again";;
 esac

# install WEB INTERFACE for mail (Squirrelmail, Horde)
# Roundcube was installed before with iredMail
echo "---------------------------------------------------";
echo "Would you like to set up WEB INTERFACE for mail?";
echo "---------------------------------------------------";
echo "Squirrelmail";
echo "Horde";
echo "q= quit";
echo "----------------------------------------------------";


read -p 'Please, enter check variable (S/H/q): ' install_web_interface
case ${install_web_interface} in
    Squirrelmail|squirrelmail|s|S) {
                       echo "Squirrelmail: $install_web_interface"      
		       cd /usr/local/src/ && wget http://downloads.sourceforge.net/project/squirrelmail/stable/1.4.22/squirrelmail-webmail-1.4.22.zip
		       unzip squirrelmail-webmail-* -d /var/www/
		       mv /var/www/squirrelmail-webmail-*/ /var/www/squirrelmail
		       chown -R apache: /var/www/squirrelmail
		       #cp -p /var/www/squirrelmail/config/config_default.php /var/www/squirrelmail/config/config.php 
                       /bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/squirrelmail/config.php /var/www/squirrelmail/config/
                       /bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/squirrelmail/squirrelmail.conf /etc/httpd/conf.d/
                       
                       # Add below lines before </VirtualHost>
		       echo "Alias /squirrelmail "/var/www/squirrelmail/"" > /etc/httpd/conf.d/ssl.conf
		       service httpd restart;
		  
                       echo "-------------------------";                                                
                       echo "Done.";                                                                    
                       echo "-------------------------"; 
                    };;
      Horde|horde|h|H) { 
                        echo "Horde: $install_web_interface"
                        cd /usr/local/src/ && wget
                        
                        /bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/horde/ /var/www/horde/
                        /bin/cp -R -f /usr/local/src/postfix-dovecot-mysql-roundcube/horde/horde.conf /etc/httpd/conf.d/
                       
                        
                        # Add below lines before </VirtualHost>
		        echo "Alias /horde "/var/www/horde/"" > /etc/httpd/conf.d/ssl.conf
		        
		        service httpd restart;
                        echo "-------------------------";                                                
                        echo "Done.";                                                                    
                        echo "-------------------------";    
                       };;                  
    q|quit) exit 1     ;;
     *) echo "error: not correct variable, try to start this script again";;
 esac
echo "=====================================================";
echo "========================DONE!========================";
echo "=====================================================";

#
#remove trash
read -p 'Would you like to delete the GIT repo from server (Yes/No/quit)? ' delete_git_repo
case ${delete_git_repo} in
    Yes|Y|y|YES) {
                  rm -rf /usr/local/src/postfix-dovecot-mysql-roundcube
                  };;
    Not|not|NOT|No|NO|N|n) {
    			    echo "---------------------------------------------------------------------------------";
                            echo "GIT Repository has not been removed from server. SEE it on folder /usr/local/src/";
                            echo "---------------------------------------------------------------------------------";
                            };;              
    q|quit) exit 1     ;;
     *) echo "error: not correct variable, try to start this script again";;
 esac
echo "=====================================================";
echo "======================FINISHED!======================";
echo "=====================================================";
