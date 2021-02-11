LAMP Stack - Web Stack (MySQL)
==============================

LAMP stack is a popular open source web platform commonly used to run
dynamic web sites and servers. It includes Linux, Apache, MariaDB (MySQL
drop-in replacement), and PHP/Python/Perl. It is considered by many, as
the platform of choice for development and deployment of high performance
web applications which require a solid and reliable foundation.

LAMP stack includes all the standard features in `TurnKey Core`_, and on
top of that:

- SSL support out of the box.
- PHP, Python and Perl support for Apache2 and MySQL (MariaDB).
- PHP development helpers:

    - composer_ installed globally (/usr/local/bin/composer) from upstream.
    - turnkey-composer_ convenience wrapper script - runs composer as the
      'www-data' (webserver) user account.
    - `php-xdebug`_: debugging and profiling.
    - `php-pear`_: php extension and application repository.
    - php-cli: command-line interpreter.

- `Adminer`_ administration frontend for MySQL (MariaDB) (listening on port
  12322 - uses SSL).
- MariaDB_ - MySQL drop-in replacement.
- MySQLTuner_ - Perl script to review and tweak a MySQL/MariaDB
  installation.
- `Postfix`_ MTA (bound to localhost) to allow sending of email from web
  applications (e.g., password recovery).
- Webmin modules for configuring Apache2, PHP, MySQL and Postfix.

A separate `LAPP stack`_ appliance features PostgreSQL instead of MySQL.

Credentials *(passwords set at first boot)*
-------------------------------------------

-  Webmin, SSH, MySQL: username **root**

-  Adminer: username **adminer**

.. _TurnKey Core: https://www.turnkeylinux.org/core
.. _composer: https://getcomposer.org/
.. _turnkey-composer: https://github.com/turnkeylinux/common/blob/master/overlays/composer/usr/local/bin/turnkey-composer
.. _php-xdebug: https://xdebug.org/
.. _php-pear: https://pear.php.net/
.. _Adminer: https://www.adminer.org/
.. _MariaDB: https://mariadb.com/
.. _MySQLTuner: https://github.com/major/MySQLTuner-perl/blob/master/README.md
.. _Postfix: https://www.postfix.org/
.. _LAPP stack: https://www.turnkeylinux.org/lapp
