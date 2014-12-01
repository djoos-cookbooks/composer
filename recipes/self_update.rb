#
# Cookbook Name:: composer
# Recipe:: self_update
#
# Copyright 2012-2014, Escape Studios
#

include_recipe 'composer::install'

if node['composer']['home_dir'].nil?
  node.set['composer']['home_dir'] = node['composer']['install_dir']
end

execute 'composer-self_update' do
  cwd node['composer']['install_dir']
  command 'composer self-update'
  environment 'COMPOSER_HOME' => node['composer']['home_dir']
  action :run
  ignore_failure true
end
