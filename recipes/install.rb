#
# Cookbook Name:: composer
# Recipe:: install
#
# Copyright 2012-2013, Escape Studios
#

composer_composer "#{node[:composer][:install_dir]}" do
    install_globally node[:composer][:install_globally]
    prefix node[:composer][:prefix]
    url node[:composer][:url]
    action :install
end