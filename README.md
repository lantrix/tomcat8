# Description

Installs base Tomcat 8 and Java 8 for simple development purposes.
  It is a pain figuring out how to install Tomcat 8 locally, it is
  my hope that this enables more developers. Please do not use this
  code for production. The tomcat user should not be set in the
  /attributes/default.rb file, and instead should be installed in
  an encrypted databag. Also, please change he default tomcat
  password.

# Requirements

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
* `node['tomcat']['password']` Defaults to  '24pa$$42'.

# Recipes

* recipe[apt] - updates the repos
* recipe[curl::default] - installs curl
* recipe[java::default] - installs java
* recipe[tomcat::default] - installs tomcat
