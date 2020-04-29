name 'composer'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures Composer'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.7.0'
chef_version '>= 0.10.0' if respond_to?(:chef_version)

%w[debian ubuntu redhat centos fedora scientific amazon windows].each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/composer' if respond_to?(:source_url)
issues_url 'https://github.com/djoos-cookbooks/composer/issues' if respond_to?(:issues_url)

depends 'apt'
depends 'php'
depends 'windows'

recipe 'composer', 'Installs (if applicable) and self-updates composer.'
recipe 'composer::install', 'Installs composer.'
recipe 'composer::self_update', 'Installs (if applicable) and self-updates composer.'
recipe 'composer::global_configs', 'Sets up global config options via `composer config --global`'
