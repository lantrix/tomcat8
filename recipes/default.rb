#
# Cookbook Name:: tomcat_development
# Recipe:: default
#

user "tomcat" do
  comment "apache tomcat system account"
  shell node['tomcat']['shell']
  password node['tomcat']['password']
end

remote_file "#{node['tomcat']['installation_directory']}/#{node['tomcat']['tomcat_version']}.tar.gz" do
  source node['tomcat']['tomcat_url']
  checksum node['tomcat']['checksum']
  owner 'tomcat'
end

bash "extract_tomcat" do
  user 'root'
  cwd node['tomcat']['installation_directory']
  code <<-EOH
  if [ -d "#{node['tomcat']['tomcat_version']}" ]; then
    echo 'The tomcat target directory has already been extracted'
  else
    tar -xvzf "#{node['tomcat']['tomcat_version']}.tar.gz"
  fi
  EOH
end

bash "change ownership of the extracted apache directory to tomcat" do
  user 'root'
  cwd node['tomcat']['installation_directory']
  code <<-EOH
  chown -R tomcat "#{node['tomcat']['tomcat_version']}"
  EOH
end

bash "start_tomcat" do
  user "tomcat"
  cwd "#{node['tomcat']['installation_directory']}/#{node['tomcat']['tomcat_version']}/bin"
  code <<-EOH
  curl localhost:8080 > /dev/null 2&>1
  if [ $? == 0 ]; then
    echo 'Tomcat is already running'
  else
    ./catalina.sh start
  fi
  EOH
end