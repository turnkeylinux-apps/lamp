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

- `XCache`_ - PHP opcode caching acceleration.
- `Adminer`_ administration frontend for MySQL (listening on port
  12322 - uses SSL).
- `Postfix`_ MTA (bound to localhost) to allow sending of email from web
  applications (e.g., password recovery).
- Webmin modules for configuring Apache2, PHP, MySQL and Postfix.

A separate `LAPP stack`_ appliance features PostgreSQL instead of MySQL.

Logging in for Administration
-----------------------------

**No default passwords**: For security reasons there are no default
passwords. All passwords are set at system initialization, which happens
either at:

1) First login for `headless build types`_ (e.g., EC2, OpenStack, Xen)
2) First boot for non-headless build types (ISO, VM, VMDK)

**Ignore SSL browser warning**: browsers don't like self signed SSL
certificates, but this is the only kind that can be generated
automatically without paying a commercial Certificate Authority. 
  
**Username for database administration**

  Login as MySQL username **root** to:
  
  1) https://12.34.56.789:12322/ - Adminer database management web app

  2) MySQL command line tool::
  
        $ mysql --user root --password
        Enter password: 
        Welcome to the MySQL monitor.  Commands end with ; or \g.
        Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

        mysql>

**Username for OS system administration**:

  Login as **root** except on `AWS marketplace`_ which uses username
  **admin**.

  1) Point your browser to:

     - https://12.34.56.789:12321/ - Web management interface 
     - https://12.34.56.789:12320/ - AJAX web terminal
       
  2) Login with SSH client::
  
      ssh root@12.34.56.789

     Special case for AWS marketplace::

      ssh admin@12.34.56.789 
      
  \* Replace 12.34.56.789 with a valid IP or hostname.

.. _headless build types: https://www.turnkeylinux.org/docs/builds#builds-table
.. _AWS marketplace: https://aws.amazon.com/marketplace
.. _TurnKey Core: https://www.turnkeylinux.org/core
.. _phpsh: http://www.phpsh.org/
.. _php5-xdebug: http://xdebug.org/
.. _php-pear: http://pear.php.net/
.. _XCache: http://xcache.lighttpd.net/
.. _Adminer: http://www.adminer.org/
.. _Postfix: http://www.postfix.org/
.. _LAPP stack: https://www.turnkeylinux.org/lapp
