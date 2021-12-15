name             'composer'
maintainer       'David Joos'
maintainer_email 'development@davidjoos.com'
license          'MIT'
description      'Installs/Configures Composer'
version          '2.7.0'
chef_version     '>= 15.3'

%w(debian ubuntu redhat centos fedora scientific amazon windows).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/composer'
issues_url 'https://github.com/djoos-cookbooks/composer/issues'

depends 'apt'
depends 'php'
depends 'windows'
