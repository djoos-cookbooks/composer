#
# Cookbook Name:: composer
# Resource:: install_global
#
# Copyright 2012-2014, Escape Studios
#

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :install do
  install_global_install
  new_resource.updated_by_last_action(true)
end

action :remove do
  install_global_remove
  new_resource.updated_by_last_action(true)
end

action :update do
  install_global_update
  new_resource.updated_by_last_action(true)
end

def install_global_install
  quiet = '--verbose' #new_resource.quiet ? '--quiet' : ''
  optimize = new_resource.optimize_autoloader ? '--optimize-autoloader' : ''
  prefer_dist = new_resource.prefer_dist ? '--prefer-dist' : ''
  prefer_source = new_resource.prefer_source ? '--prefer-source' : ''
  prefer_stable = new_resource.prefer_stable ? '--prefer-stable' : ''
  package = new_resource.package

  execute "composer-install-global-#{package}" do
    command "#{node['composer']['bin']} global require --no-interaction --no-ansi #{quiet} #{optimize} #{prefer_dist} #{prefer_source} #{prefer_stable} #{package}"
    environment 'COMPOSER_HOME' => Composer.home_dir(node), 'COMPOSER_BIN_DIR' => Composer.bin_dir(node)
    action :run
    user new_resource.user
    group new_resource.group
    umask new_resource.umask
    environment "COMPOSER_HOME" => "/home/vagrant"
    not_if "#{node['composer']['bin']} global show #{new_resource.package}"
  end

  # directory new_resource.install_dir do
  #   recursive true
  #   user new_resource.user
  #   group new_resource.group
  # end

  # composer_project new_resource.vendor do
  #   project_dir new_resource.install_dir
  #   dev new_resource.dev
  #   quiet new_resource.quiet
  #   optimize new_resource.optimize_autoloader
  #   prefer_dist new_resource.prefer_dist
  #   prefer_source new_resource.prefer_source
  #   user new_resource.user
  #   group new_resource.group
  #   umask new_resource.umask
  #   action :require
  # end

  # # Set the bin_dir for completeness
  # execute 'set-bin_dir' do
  #   cwd new_resource.install_dir
  #   command "#{node['composer']['bin']} config bin-dir #{node['composer']['bin_dir']} #{quiet}"
  #   environment 'COMPOSER_HOME' => Composer.home_dir(node)
  #   action :run
  #   user new_resource.user
  #   group new_resource.group
  #   umask new_resource.umask
  # end
end
