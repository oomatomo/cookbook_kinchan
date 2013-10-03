#
# Cookbook Name:: cookbook_kinchan
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#
include_recipe 'nginx'
include_recipe 'php'
include_recipe 'git'

# git clone app's code
git "#{node['kinchan']['path']}" do
  repository 'https://github.com/oomatomo/kif.git'
  action :checkout
end

# setting nginx
nginx_site 'default' do
  enable false
end

file "/etc/nginx/conf.d/default.conf" do
  action :delete
end

template "#{node['nginx']['dir']}/sites-enabled/default" do
  source 'default-site.erb'
  notifies :restart, 'service[nginx]'
end

service "iptables" do
  action :stop
end

include_recipe 'mysql::ruby'
include_recipe 'mysql::server'
include_recipe 'database::mysql'
# create mysql
mysql_connection_info = {
  :host => node['kinchan']['database']['host'],
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database node['kinchan']['database']['name'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['kinchan']['database']['user'] do
  connection mysql_connection_info
  password node['kinchan']['database']['pass']
  database_name node['kinchan']['database']['name']
  action [ :create, :grant ]
end

cookbook_file node['kinchan']['database']['sql_file'] do
  source "kif.sql"
  owner "root"
  group "root"
  mode "0600"
end

execute "create mysql table" do
  command "mysql -h #{node['kinchan']['database']['host']} -u #{node['kinchan']['database']['user']} -p#{node['kinchan']['database']['pass']} -D #{node['kinchan']['database']['name']} < #{node['kinchan']['database']['sql_file']}"
  not_if  "mysql -h #{node['kinchan']['database']['host']} -u #{node['kinchan']['database']['user']} -p#{node['kinchan']['database']['pass']} -D #{node['kinchan']['database']['name']}  -e 'describe users;'"
end
