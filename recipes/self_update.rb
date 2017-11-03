#
# Cookbook Name:: composer
# Recipe:: self_update
#
# Copyright (c) 2016, David Joos
#

include_recipe 'composer::install'

channel = (node['composer']['selfupdate_channel'] == nil) ? "" : (" --" + node['composer']['selfupdate_channel'])

execute 'composer-self_update' do
  cwd node['composer']['install_dir']
  command 'composer self-update' + channel 
  environment 'COMPOSER_HOME' => Composer.home_dir(node)
  action :run
  ignore_failure true
end

