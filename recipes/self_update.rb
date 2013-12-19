#
# Cookbook Name:: composer
# Recipe:: self_update
#
# Copyright 2012-2013, Escape Studios
#

include_recipe 'composer::install'

execute 'selfupdate_composer' do
  cwd node['composer']['dir']
  command "composer self-update"
  action :run
end