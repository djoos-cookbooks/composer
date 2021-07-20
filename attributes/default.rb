#
# Cookbook:: composer
# Attributes:: default
#
# Copyright:: 2016-2021, David Joos
#

include_attribute 'php'

if platform?('windows')
  default['composer']['url'] = 'https://getcomposer.org/Composer-Setup.exe'
  default['composer']['install_dir'] = 'C:\\ProgramData\\ComposerSetup'
  default['composer']['bin'] = "#{node['composer']['install_dir']}\\composer.bat"
  default['composer']['global_install']['install_dir'] = 'C:\\Program\ Files\\Composer'
  default['composer']['global_install']['bin_dir'] = 'C:\\ProgramData\\Composer'
else
  default['composer']['url'] = 'http://getcomposer.org/composer-stable.phar'
  default['composer']['install_dir'] = '/usr/local/bin'
  default['composer']['bin'] = "#{node['composer']['install_dir']}/composer"
  default['composer']['install_globally'] = true
  default['composer']['mask'] = '0755'
  default['composer']['link_type'] = :symbolic
  default['composer']['global_install']['install_dir'] = '/usr/local/composer'
  default['composer']['global_install']['bin_dir'] = '/usr/local/bin'
end

default['composer']['global_configs'] = {}
default['composer']['home_dir'] = nil
default['composer']['php_recipe'] = 'php::default'
default['composer']['self_update_channel'] = nil
