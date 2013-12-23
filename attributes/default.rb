#
# Cookbook Name:: composer
# Attributes:: default
#
# Copyright 2012-2013, Escape Studios
#

if node['platform'] == "windows"
    default['composer']['url'] = "https://getcomposer.org/Composer-Setup.exe"
    default['composer']['install_dir'] = "C:\\ProgramData\\ComposerSetup"
    default['composer']['bin'] = "#{node['composer']['install_dir']}\\composer.bat"
else
    default['composer']['url'] = "http://getcomposer.org/composer.phar"
    default['composer']['install_dir'] = "/usr/local/bin"
    default['composer']['install_globally'] = true
    default['composer']['bin'] = "#{node['composer']['install_dir']}/composer"
end

default['composer']['php_recipe'] = "php::default"