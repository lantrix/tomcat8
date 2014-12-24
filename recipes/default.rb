#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/opt/#{node['tomcat']['tomcat_version']}.tar.gz" do
  source "#{node['tomcat']['tomcat_url']}"
end

bash "extract_tomcat" do
  user "root"
  cwd "/opt"
  code <<-EOH
  tar -xvzf "#{node['tomcat']['tomcat_version']}.tar.gz"
  cd "#{node['tomcat']['tomcat_version']}"
  EOH
end

bash "create_the_tomcat_user" do
  user "root"
  code <<-EOH
  adduser tomcat
  EOH
end

bash "change_ownership_of_the_tomcat_directory_to_the_user_tomcat" do
  user "root"
  cwd "/opt"
  code <<-EOH
  chown -R tomcat "#{node['tomcat']['tomcat_version']}"
  EOH
end

bash "start_tomcat" do
  user "tomcat"
  cwd "/opt/#{node['tomcat']['tomcat_version']}/bin"
  code <<-EOH
  ./catalina.sh start
  EOH
end

