#
# Cookbook:: composer
# Recipe:: install
#
# Copyright:: 2016-2021, David Joos
#

include_recipe node['composer']['php_recipe']

if platform?('windows')
  windows_package 'Composer - PHP Dependency Manager' do
    source node['composer']['url']
    options %w(
      /VERYSILENT
    ).join(' ')
  end

  install_dir = "#{node['composer']['install_dir'].tr('/', '\\')}\\bin"

  ENV['PATH'] += ";#{install_dir}"
  windows_path install_dir
else
  log '[composer] phar (PHP archive) not supported' do
    level :warn
    not_if "php -m | grep 'Phar'"
  end

  file = node['composer']['install_globally'] ? "#{node['composer']['install_dir']}/composer" : "#{node['composer']['install_dir']}/composer.phar"

  remote_file file do
    source node['composer']['url']
    mode node['composer']['mask']
    action :create
    not_if { ::File.exist?(file) }
  end
end
