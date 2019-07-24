#!/bin/sh

set -ex
export GO111MODULE=on

sudo apt-get -qq update
sudo apt-get install -y mysql-server-5.7
echo "[mysqld]\nserver-id=1\nbinlog-format=ROW\ngtid_mode=ON\nenforce-gtid-consistency\nlog_bin=/var/log/mysql/mysql-bin.log\nlog_slave_updates=1"|sudo tee -a /etc/mysql/my.cnf
sudo service mysql restart

#https://gist.github.com/Mins/4602864

#Automating mysql_secure_installation
#https://www.osradar.com/how-to-install-mariadb-or-mysql-on-ubuntu-18-04/

#ysqladmin -u root password "$DATABASE_PASS"
#mysql -u root -p"$DATABASE_PASS" -e "UPDATE mysql.user SET Password=PASSWORD('$DATABASE_PASS') WHERE User='root'"
#mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
#mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
#mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
#mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES
#CREATE DATABASE testdb

#$ sudo mysql -u root # I had to use "sudo" since is new installation
#
#mysql> USE mysql;
#mysql> UPDATE user SET plugin='mysql_native_password' WHERE User='root';
#mysql> FLUSH PRIVILEGES;
#mysql> exit;

#mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';
#Query OK, 0 rows affected (0.03 sec)
#
#mysql> FLUSH PRIVILEGES;
#Query OK, 0 rows affected (0
#systemctl restart mysql
#mysql -u root -p"123456" -e 'CREATE DATABASE storagetapper'
#go get github.com/Masterminds/glide
#go get github.com/alecthomas/gometalinter
curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $(go env GOPATH)/bin v1.17.1
#GO111MODULE=on go get github.com/golangci/golangci-lint/cmd/golangci-lint@v1.17.1
go get github.com/tinylib/msgp
#gometalinter --install
/bin/sh scripts/install_kafka.sh
/bin/sh scripts/install_hadoop.sh
