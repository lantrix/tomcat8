#
# Cookbook Name:: tomcat
# Recipe:: default
#

remote_file "/opt/#{node['tomcat']['tomcat_version']}.tar.gz" do
  source node['tomcat']['tomcat_url']
  checksum node['tomcat']['checksum']
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
  getent passwd tomcat > /dev/null 2&>1
  if [ $? == 0 ]; then
    echo 'tomcat already exists'
  else
    adduser --disabled-password --gecos "" tomcat
    echo -e "#{node['tomcat']['password']}\n#{node['tomcat']['password']}" | passwd tomcat
  fi
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

