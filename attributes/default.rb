#
# Cookbook Name:: composer
# Attributes:: default
#
# Copyright (c) 2016, David Joos
#

include_attribute 'php'

if node['platform'] == 'windows'
  default['composer']['url'] = 'https://getcomposer.org/Composer-Setup.exe'
  default['composer']['install_dir'] = 'C:\\ProgramData\\ComposerSetup'
  default['composer']['bin'] = "#{node['composer']['install_dir']}\\composer.bat"
  default['composer']['global_install']['install_dir'] = 'C:\\Program\ Files\\Composer'
  default['composer']['global_install']['bin_dir'] = 'C:\\ProgramData\\Composer'
else
  default['composer']['version'] = '1.3.2'
  default['composer']['url'] = "https://getcomposer.org/download/#{node['composer']['version']}/composer.phar"
  default['composer']['checksum'] = '6a4f761aa34bb69fca86bc411a5e9836ca8246f0fcd29f3804b174fee9fb0569'
  default['composer']['install_dir'] = '/usr/local/bin'
  default['composer']['bin'] = "#{node['composer']['install_dir']}/composer"
  default['composer']['install_globally'] = true
  default['composer']['mask'] = 0755
  default['composer']['link_type'] = :symbolic
  default['composer']['global_install']['install_dir'] = '/usr/local/composer'
  default['composer']['global_install']['bin_dir'] = '/usr/local/bin'
end

default['composer']['global_configs'] = {}
default['composer']['home_dir'] = nil
default['composer']['php_recipe'] = 'php::default'
