#
# Cookbook:: composer
# Recipe:: install
#
# Copyright:: 2016-2022, David Joos
#

log 'php check' do
  level :fatal
  message 'PHP is not installed. Please install PHP before including this recipe (e.g. with the `php` cookbook)'
  not_if 'php --version'
end

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
    action :create_if_missing
  end
end
