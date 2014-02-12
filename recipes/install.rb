#
# Cookbook Name:: composer
# Recipe:: install
#
# Copyright 2012-2013, Escape Studios
#

include_recipe node['composer']['php_recipe']

if node['platform'] == "windows"
    windows_package "Composer - PHP Dependency Manager" do
        source node['composer']['url']
        options %W[
          /VERYSILENT
        ].join(' ')
    end

    install_dir = "#{node['composer']['install_dir'].gsub('/', '\\')}\\bin"

    ENV['PATH'] += ";#{install_dir}"
    windows_path install_dir
else
    cache_dir = "#{Chef::Config[:file_cache_path]}/composer"

    directory cache_dir do
        action :create
    end

    cache_file = "#{cache_dir}/composer.phar"

    remote_file cache_file do
        source node['composer']['url']
        mode node['composer']['chmod']
        action :create
        not_if do
            ::File.exists?(cache_file)
        end
    end

    if node['composer']['install_globally']
        file = "#{node['composer']['install_dir']}/composer"
    else
        file = "#{node['composer']['install_dir']}/composer.phar"
    end

    link file do
        to cache_file
        action :create
    end
end
