#
# Cookbook Name:: cookbook_kinchan
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#
include_recipe 'mysql'
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
