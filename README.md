## postfix-dovecot-mysql-roundcube
postfix + dovecot with mysql and roundcube


##INSTALL

Install git.

CentOS/RedHat/Fedora:
`# yum install git`

Debian/ubuntu/Mint:
`# apt-get install git`

`# cd /usr/local/src/ && git clone https://github.com/SebastianUA/postfix-dovecot-mysql-roundcube.git`

##Start script.
Debian's:

`$ bash /usr/local/src/postfix-dovecot-mysql-roundcube/install-Debians.sh` IN PROCESS! 

RedHad's:

`$ bash /usr/local/src/postfix-dovecot-mysql-roundcube/install-RHELs.sh` IN TESTING!

PS: If mysql works without a password (registered in the file), you need to edit the script. Open for editing and make the change of the text:

`# vim /usr/local/src/postfix-dovecot-mysql-roundcube/install-RHELs.sh`

`# vim /usr/local/src/postfix-dovecot-mysql-roundcube/install-Debians.sh`

and insert the command to replace:

`:%s/-uroot -p//g`

## Test accounts 

I created the following test accounts:

- For domain localhost.test.local

Username_1: postmaster@localhost.test.local

Username_2: test_user@localhost.test.local

Password:   QWERTY####12|34

- For domain test.com.local

Username: test@test.com.local

Password: QWERTY####12|34







