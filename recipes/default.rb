#
# Cookbook:: composer
# Recipe:: default
#
# Copyright:: 2016-2021, David Joos
#

include_recipe 'composer::install'

if node['composer']['install_globally']
  include_recipe 'composer::global_configs'
end
