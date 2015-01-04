# Description

Installs base Tomcat 8 and Java 8 to have a tomcat server to deploy to.
  It is a pain figuring out how to install Tomcat 8 locally, it is
  my hope that this enables more developers. To access this vm, you
  can either ssh in via port 2222 - user: tomcat password: 24pa$$42,
  or curl localhost:8080.

# Requirements

* rvm / ruby
* cd into the directory where you downloaded this cookbook
* `rvm gemset use tomcat_development --create`
* `berks install`
* `bundle`
* `kitchen converge`
* You now have a running Tomcat server to deploy to.

## Platform:

* Ubuntu

## Cookbooks:

* apt
* curl
* java

# Attributes:

* `node['tomcat']['tomcat_version']` - Defaults to apache-tomcat-8.0.15.
* `node['tomcat']['tomcat_url']` - Defaults to 'http://mirrors.gigenet.com/apache/tomcat/tomcat-8/v8.0.15/bin/apache-tomcat-8.0.15.tar.gz'.
* `node['tomcat']['checksum']` - Defaults to  '2cc244070d01193c541e526564068e6f4e9ecade22380e38e681e931f3dc3699'.
* `node['tomcat']['password']` - Defaults to  '$1$FriiRKvW$rhegRwjAuhDdIcaXp6UC.1' which is the output of:
  'openssl passwd -1 24pa$$42'.
* `node['tomcat']['shell']` - Set the shell for the tomcat user. Defaults to /bin/bash.

# Recipes

* recipe[apt] - updates the repos
* recipe[curl::default] - installs curl
* recipe[java::default] - installs java
* recipe[tomcat::default] - installs tomcat
