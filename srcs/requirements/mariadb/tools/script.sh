#!/bin/bash

echo "MYSQL_DB_NAME: $MYSQL_DB_NAME"
echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
echo "MYSQL_USER: $MYSQL_USER"
echo "MYSQL_PASSWORD: $MYSQL_PASSWORD"

/etc/init.d/mysql start

sleep 5
# Check if the database already exists
if [ -d "/var/lib/mysql/$MYSQL_DB_NAME" ]; then
	echo "Database already exists"
else
	mysqladmin -u root password $MYSQL_ROOT_PASSWORD
	#mysqladmin -u root password P@lm78070
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME ;" > db.sql
	#echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" >> db.sql
	echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> db.sql
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%' ;" >> db.sql
	echo "FLUSH PRIVILEGES;" >> db.sql

	mysql -uroot -p$MYSQL_ROOT_PASSWORD < db.sql
	#mysql < db.sql

	rm -rf db.sql

	#Stop mysql server
	mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown

	#Wait for mysql server to stop
	while ps aux | grep -v grep | grep mysqld; do
		sleep 1
	done
fi

#mysqld_safe --user=mysql --console --skip-name-resolve --skip-networking=0
#exec "$@"

######################################################################

#/etc/init.d/mysql start
#
#sleep 5
## Check if the database already exists
#if [ -d "/var/lib/mysql/WordpressDB" ]; then
#	echo "Database already exists"
#else
#	mysqladmin -u root password P@lm78070
#	echo "CREATE DATABASE IF NOT EXISTS WordpressDB ;" > db.sql
#	#echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'P@lm78070' ;" >> db.sql
#	echo "CREATE USER IF NOT EXISTS 'Palm'@'%' IDENTIFIED BY '1234' ;" >> db.sql
#	echo "GRANT ALL PRIVILEGES ON WordpressDB.* TO 'Palm'@'%' ;" >> db.sql
#	echo "FLUSH PRIVILEGES;" >> db.sql
#
#	mysql -uroot -pP@lm78070 < db.sql
#
#	#Stop mysql server
#	mysqladmin -uroot -pP@lm78070 shutdown
#
#	#Wait for mysql server to stop
#	while ps aux | grep -v grep | grep mysqld; do
#		sleep 1
#	done
#fi
