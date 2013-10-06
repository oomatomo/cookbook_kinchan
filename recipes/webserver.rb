# setting php-fpm
package 'php-fpm' do
    action [:install, :upgrade]
end

file "/etc/php-fpm.d/www.conf" do
  action :delete
end

template "/etc/php-fpm.d/www.conf" do
  mode 0644
  source "php-fpm-www.conf.erb"
end

service 'php-fpm' do
  action :start
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



