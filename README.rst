LAMP Stack - Web Stack (MySQL)
==============================

LAMP stack is a popular open source web platform commonly used to run
dynamic web sites and servers. It includes Linux, Apache, MySQL, and
PHP/Python/Perl and is considered by many the platform of choice for
development and deployment of high performance web applications which
require a solid and reliable foundation.

LAMP stack includes all the standard features in `TurnKey Core`_, and on
top of that:

- SSL support out of the box.
- PHP, Python and Perl support for Apache2 and MySQL.
- PHP development helpers

    - `phpsh`_: interactive shell
    - `php5-xdebug`_: debugging and profiling
    - `php-pear`_: php extension and application repository
    - php5-cli: command-line interpreter

- `Adminer`_ administration frontend for MySQL (listening on port
  12322 - uses SSL).
- `Postfix`_ MTA (bound to localhost) to allow sending of email from web
  applications (e.g., password recovery).
- Webmin modules for configuring Apache2, PHP, MySQL and Postfix.

A separate `LAPP stack`_ appliance features PostgreSQL instead of MySQL.

Credentials *(passwords set at first boot)*
-------------------------------------------

-  Webmin, SSH, MySQL, Adminer: username **root**

.. _TurnKey Core: https://www.turnkeylinux.org/core
.. _phpsh: http://www.phpsh.org/
.. _php5-xdebug: http://xdebug.org/
.. _php-pear: http://pear.php.net/
.. _Adminer: http://www.adminer.org/
.. _Postfix: http://www.postfix.org/
.. _LAPP stack: https://www.turnkeylinux.org/lapp
