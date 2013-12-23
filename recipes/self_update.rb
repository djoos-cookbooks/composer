#
# Cookbook Name:: composer
# Recipe:: self_update
#
# Copyright 2012-2013, Escape Studios
#

include_recipe "composer::install"

execute "composer-self_update" do
    cwd node['composer']['install_dir']
    command "composer self-update"
    action :run
end