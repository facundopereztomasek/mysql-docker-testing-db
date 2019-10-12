FROM mysql
ARG MYSQL_ROOT_PASSWORD
RUN echo "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';GRANT ALL PRIVILEGES ON *.* to 'root'@'%';FLUSH PRIVILEGES;" > /docker-entrypoint-initdb.d/script.sql
RUN chmod -R 775 /docker-entrypoint-initdb.d