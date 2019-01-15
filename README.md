u16phpall
===============

Shippable CI image for PHP on Ubuntu 16.04. Available PHP versions:

  1. PHP 7.1.25
  2. PHP 7.2.14
  3. PHP 7.3.1
  
  

Each PHP version is installed with php-build and managed with phpenv. Several 
PHP extensions are also available out of the box. Unless otherwise noted, the 
latest version of the extension at the time the image was built is what is 
available in the image:

  1. PHP 7.1.25, PHP 7.2.14 and 7.3.1

      * amqp
      * bzip
      * intl
      * memcached
      * redis
      * zmq
      
u16phpall Docker Hub repo: [drydock/u16phpall](https://hub.docker.com/r/drydock/u16phpall/)

**Services**

This image is built on top of [u16all](https://github.com/dry-dock/u16all) .Please check 
there for a list of all the services.
