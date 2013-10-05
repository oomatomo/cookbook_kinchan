#
# Cookbook Name:: cookbook_kinchan
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# about webserver.rb
include_recipe 'nginx'
include_recipe 'php'
include_recipe 'git'

# about database.rb
include_recipe 'mysql::ruby'
include_recipe 'mysql::server'
include_recipe 'database::mysql'

# git clone app's code
git "#{node['kinchan']['path']}" do
  repository 'https://github.com/oomatomo/kif.git'
  action :checkout
end

# do my recipe
include_recipe 'cookbook_kinchan::database'
include_recipe 'cookbook_kinchan::webserver'
