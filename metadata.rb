name             'cookbook_kinchan'
maintainer       'Tomohisa Omagari'
maintainer_email 'ooma0301@gmail.com'
license          'All rights reserved'
description      'Installs/Configures cookbook_kinchan'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "mysql", "~> 3.0.0"
depends "nginx", "~> 1.8.0"
depends "php", "~> 1.2.4"
depends "git", "~> 2.6.0"
depends "database", "1.5.0"
