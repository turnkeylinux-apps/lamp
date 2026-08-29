#!/bin/bash
set -euo pipefail
umask 077

result=${TKL_TEST_RESULT:?TKL_TEST_RESULT is required}
password=${TKL_TEST_DB_PASS:?TKL_TEST_DB_PASS is required}
work=/run/tkl-v19-tests/lamp
database=tkl_v19_lamp_$$
table_name=persistence
php_test=/var/www/tkl-v19-lamp-db.php
client_conf=$work/client.cnf
password_file=$work/db-password

mysql_qa() {
    mysql --defaults-extra-file="$client_conf" "$@"
}

cleanup() {
    status=$?
    trap - EXIT
    mysql_qa --execute="DROP DATABASE IF EXISTS \`$database\`;" \
        >/dev/null 2>&1 || true
    rm -f -- "$php_test"
    rm -rf -- "$work"
    exit "$status"
}
trap cleanup EXIT

install -d -o root -g www-data -m 0750 "$work"
cat >"$client_conf" <<EOF
[client]
user=root
password=$password
EOF
chmod 0600 "$client_conf"

systemctl --quiet is-active \
    apache2.service mariadb.service multi-user.target
grep -Fq 'Inithooks run completed' /var/log/inithooks.log
apache2ctl configtest 2>&1 | grep -Fq 'Syntax OK'
php -m | grep -Fxq mysqli

curl -kfsS https://127.0.0.1/ >"$work/landing.html"
grep -Eqi 'TurnKey.*LAMP|LAMP' "$work/landing.html"
curl -kfsS https://127.0.0.1:12322/ >"$work/adminer.html"
grep -Fqi Adminer "$work/adminer.html"

mysql_qa <<SQL
CREATE DATABASE \`$database\`;
CREATE TABLE \`$database\`.\`$table_name\` (message varchar(64) NOT NULL);
INSERT INTO \`$database\`.\`$table_name\` VALUES ('lamp-v19-persistence');
SQL
printf '%s' "$password" >"$password_file"
chown root:www-data "$password_file"
chmod 0640 "$password_file"
cat >"$php_test" <<PHP
<?php
\$password = trim(file_get_contents('$password_file'));
\$database = new mysqli('localhost', 'adminer', \$password, '$database');
if (\$database->connect_error) { http_response_code(500); exit('connect-failed'); }
\$result = \$database->query('SELECT message FROM $table_name');
if (!\$result) { http_response_code(500); exit('query-failed'); }
header('Content-Type: text/plain');
echo \$result->fetch_row()[0];
?>
PHP
chmod 0644 "$php_test"

curl -kfsS https://127.0.0.1/tkl-v19-lamp-db.php \
    >"$work/flow-before-restart.txt"
grep -Fxq lamp-v19-persistence "$work/flow-before-restart.txt"

systemctl restart mariadb.service apache2.service
systemctl --quiet is-active mariadb.service apache2.service
curl -kfsS https://127.0.0.1/tkl-v19-lamp-db.php \
    >"$work/flow-after-restart.txt"
grep -Fxq lamp-v19-persistence "$work/flow-after-restart.txt"

apache_version=$(dpkg-query -W -f='${Version}' apache2)
php_version=$(dpkg-query -W -f='${Version}' libapache2-mod-php)
mariadb_version=$(dpkg-query -W -f='${Version}' mariadb-server)
adminer_version=$(dpkg-query -W -f='${Version}' adminer)
for package in apache2 libapache2-mod-php mariadb-server adminer; do
    candidate=$(apt-cache policy "$package" | awk '/Candidate:/ {print $2}')
    test -n "$candidate" && test "$candidate" != '(none)'
done
grep -Rqs '^Suites:.*trixie' /etc/apt/sources.list.d
if test -f /etc/apt/sources.list; then
    ! grep -qi bookworm /etc/apt/sources.list
fi
! grep -Rqi bookworm /etc/apt/sources.list.d
! grep -F -- "$password" /var/log/inithooks.log

cat >"$result" <<EOF
package_source=Debian Trixie APT packages for Apache, PHP, MariaDB and Adminer
installed_version=apache2 $apache_version; libapache2-mod-php $php_version; mariadb-server $mariadb_version; adminer $adminer_version
runtime_checks=normal firstboot completion, Apache HTTPS and PHP mysqli, MariaDB-backed PHP request across Apache and database restart, and Adminer HTTPS reachability
updater_command=apt-cache policy apache2 libapache2-mod-php mariadb-server adminer
updater_result=eligible APT candidates found; installed packages unchanged
updater_channel=Debian and TurnKey Trixie signed APT repositories
integrity_evidence=installed dpkg state and configured signed Trixie Deb822 repositories; no Bookworm source remains
EOF
