#
# Cookbook Name:: composer
# Recipe:: install
#
# Copyright 2012-2013, Escape Studios
#

include_recipe "php"

if platform?('windows')

  windows_package "Composer - Php Dependency Manager" do
    source node['composer']['package']
    options %W[
          /VERYSILENT
    ].join(' ')
  end

  install_dir = "#{node['composer']['dir'].gsub('/', '\\')}\\bin"

  ENV['PATH'] += ";#{install_dir}"
  windows_path install_dir

else

  directory node['composer']['dir'] do
    owner 'root'
    group 'root'
    mode  '00755'
    action :create
  end

  remote_file "#{node['composer']['dir']}/composer.phar" do
    source node['composer']['package']
    action :create
  end

  link "#{node['composer']['dir']}/composer" do
    to "#{node['composer']['dir']}/composer.phar"
    action :create
  end

  if node['composer']['install_globally']
    link node['composer']['global_link'] do
      to "#{node['composer']['dir']}/composer"
      action :create
    end
  end

end
