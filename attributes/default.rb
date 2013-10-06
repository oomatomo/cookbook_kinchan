
default['kinchan']['path'] = "/var/www/kif"
default['kinchan']['database']['host'] = '127.0.0.1'
default['kinchan']['database']['name'] = 'kif'
default['kinchan']['database']['user'] = 'kin'
default['kinchan']['database']['pass'] = 'kin'
default['kinchan']['database']['sql_file'] = '/tmp/kif.sql'

default['mysql']['server_root_password'] = 'rootpass'
default['mysql']['server_debian_password'] = 'debpass'
default['mysql']['server_repl_password'] = 'replpass'
default['mysql']['bind_address'] = default['kinchan']['database']['host']

default['php-fpm']['host'] = '127.0.0.1:9000'
default['php-fpm']['user'] = 'nginx'
default['php-fpm']['group'] = 'nginx'

