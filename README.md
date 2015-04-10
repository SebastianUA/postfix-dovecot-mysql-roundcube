## postfix-dovecot-mysql-roundcube
postfix + dovecot with mysql and roundcube


##INSTALL

Install git.

CentOS/RedHat/Fedora:
`# yum install git`

Debian/ubuntu/Mint:
`# apt-get install git`

`# cd /usr/local/src/ && git clone https://github.com/SebastianUA/postfix-dovecot-mysql-roundcube.git`

# 1. create the DBs and the users.

`# mysql -uroot -p`

create new DB iredadmin with the new user iredadmin:

`> CREATE database iredadmin;`

`> GRANT ALL ON iredadmin.* TO iredadmin@localhost IDENTIFIED BY 'iredadmin_pw’;`

create new DB roundcube with the new user roundcube:

`> CREATE database roundcube;`

`> GRANT ALL ON roundcube.* TO roundcube@localhost IDENTIFIED BY 'roundcube_pw';`

create new DB vmail with the new user vmail:

`> CREATE database vmail;`

`> GRANT ALL ON vmail.* TO vmail@localhost IDENTIFIED BY 'vmail'_pw;`

add grant privileges for the new user vmailadmin:

`> GRANT ALL ON vmail.* TO vmailadmin@localhost IDENTIFIED BY 'vmailadmin_pw';`

# 2. Restore all DBs to the created DBs.






