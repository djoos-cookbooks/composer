#
# Cookbook:: composer
# Recipe:: self_update
#
# Copyright:: 2016-2021, David Joos
#

include_recipe 'composer::install'

channel = if node['composer']['self_update_channel'].nil?
            ''
          else
            " --#{node['composer']['self_update_channel']}"
          end

execute 'composer-self_update' do
  cwd node['composer']['install_dir']
  command 'composer self-update' + channel
  environment 'COMPOSER_HOME' => composer_home_dir(node)
  action :run
  ignore_failure true
end
