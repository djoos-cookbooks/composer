#
# Cookbook Name:: composer
# Recipe:: self_update
#
# Copyright 2012-2013, Escape Studios
#

composer_composer "#{node[:composer][:install_dir]}" do
    install_globally node[:composer][:install_globally]
    action :self_update
end