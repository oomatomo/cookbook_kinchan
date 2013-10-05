
# setting database

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
