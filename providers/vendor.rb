#
# Cookbook Name:: composer
# Resource:: vendor
#
# Copyright 2012-2014, Escape Studios
#

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :require do
  get_vendor_execute 'require'
  make_execute 'install'
  new_resource.updated_by_last_action(true)
end

def get_vendor_execute(cmd)
  dev = new_resource.dev ? '--dev' : '--update-no-dev'
  vendor = new_resource.vendor
  prefer_dist = new_resource.prefer_dist ? '--prefer-dist' : ''

  execute "#{cmd}-composer-for-project" do
    cwd node['composer']['install_dir']
    command "#{node['composer']['bin']} require #{vendor} #{dev} #{prefer_dist}"
    environment 'COMPOSER_HOME' => Composer.home_dir(node)
    action :run
    only_if 'which composer'
    user new_resource.user
    group new_resource.group
    umask new_resource.umask
  end
end

def make_execute(cmd)
  dev = new_resource.dev ? '--dev' : '--no-dev'
  quiet = new_resource.quiet ? '--quiet' : ''
  optimize = new_resource.optimize_autoloader ? optimize_flag(cmd) : ''
  prefer_dist = new_resource.prefer_dist ? '--prefer-dist' : ''

  execute "#{cmd}-composer-for-project" do
    cwd node['composer']['install_dir']
    command "#{node['composer']['bin']} #{cmd} --no-interaction --no-ansi #{quiet} #{dev} #{optimize} #{prefer_dist}"
    environment 'COMPOSER_HOME' => Composer.home_dir(node)
    action :run
    only_if 'which composer'
    user new_resource.user
    group new_resource.group
    umask new_resource.umask
  end
end
