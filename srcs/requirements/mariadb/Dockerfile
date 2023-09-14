FROM debian:buster

ARG MYSQL_DB_NAME
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD

#-y to automatically answer "yes" to prompts that require user confirmation during package installation or upgrade
RUN apt-get update -y && apt-get install -y \
	mariadb-server \
	mariadb-client \
	procps

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/script.sh /

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod -R 755 /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql/*

EXPOSE 3306

RUN /script.sh

ENTRYPOINT ["mysqld_safe", "--user=mysql", "--console", "--skip-name-resolve", "--skip-networking=0"]
#CMD mysqld_safe --user=mysql --console --skip-name-resolve --skip-networking=0
	# --user=mysql -> run mysqld with user mysql which have limited system privileges for security reason
	# --console -> send mysql error log/other message to terminal instead of log file
	# --skip-name-resolve -> prevent mysql server from DNS lookups when clients connect(long delay and slow performance)
	# --skip-networking=0 -> 0 enables network connections to the MySQL server(if 1 you connect only through unix socket)
