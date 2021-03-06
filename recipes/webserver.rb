# setting php-fpm
packages = %w{ php-fpm php-mysql }
packages.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end

file "/etc/php-fpm.d/www.conf" do
  action :delete
end

template "/etc/php-fpm.d/www.conf" do
  mode 0644
  source "php-fpm-www.conf.erb"
end

directory "/var/lib/php/session" do
  group "nginx"
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



