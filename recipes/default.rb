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

# setting nginx
begin
  template "#{node['nginx']['dir']}/sites-available/default" do
    source "default-site.erb"
  end
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template your template override!"
end

# git clone app's code
begin
  git "#{node['kinchan']['path']}" do
    repository "https://github.com/oomatomo/kif.git"
    action :sync
  end
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not clone app' conde!"
end
