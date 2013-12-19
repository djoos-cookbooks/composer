#
# Cookbook Name:: composer
# Attributes:: default
#
# Copyright 2012-2013, Escape Studios
#

case node["platform_family"]
  when 'windows'
    default['composer']['package'] = 'https://getcomposer.org/Composer-Setup.exe'
    default['composer']['dir'] = 'C:\ProgramData\ComposerSetup'
    default['composer']['bin'] = "#{node['composer']['dir']}\\composer.bat"
  else
    default['composer']['package'] = 'https://getcomposer.org/download/1.0.0-alpha7/composer.phar'
    default['composer']['dir'] = '/usr/local/composer'
    default['composer']['bin'] = "#{node['composer']['dir']}/composer"
    default['composer']['install_globally'] = true
    default['composer']['global_link'] = '/usr/local/bin/composer'
end