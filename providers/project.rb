#
# Cookbook Name:: composer
# Resource:: project
#
# Copyright (c) 2016, David Joos
#

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :install do
  make_execute 'install'
  new_resource.updated_by_last_action(true)
end

action :require do
  make_require
end

action :update do
  make_execute 'update'
  new_resource.updated_by_last_action(true)
end

action :dump_autoload do
  make_execute 'dump-autoload'
  new_resource.updated_by_last_action(true)
end

action :remove do
  remove_package 'remove'
end

def make_execute(cmd)
  dev = new_resource.dev ? '--dev' : '--no-dev'
  quiet = new_resource.quiet ? '--quiet' : ''
  optimize = new_resource.optimize_autoloader ? optimize_flag(cmd) : ''
  prefer_dist = new_resource.prefer_dist ? '--prefer-dist' : ''
  prefer_source = new_resource.prefer_source ? '--prefer-source' : ''

  execute "#{cmd}-composer-for-project" do
    cwd new_resource.project_dir
    command "#{node['composer']['bin']} #{cmd} --no-interaction --no-ansi #{quiet} #{dev} #{optimize} #{prefer_dist} #{prefer_source}"
    environment 'COMPOSER_HOME' => Composer.home_dir(node)
    action :run
    user new_resource.user
    group new_resource.group
    umask new_resource.umask
  end
end

def make_require
  dev = new_resource.dev ? '--dev' : '--update-no-dev'
  package = new_resource.package
  raise 'package is needed for composer_project with action require' if package.nil?
  prefer_dist = new_resource.prefer_dist ? '--prefer-dist' : ''
  version = new_resource.version ? new_resource.version : '*.*.*'

  execute 'Install-composer-for-single-project' do
    cwd new_resource.project_dir
    command "#{node['composer']['bin']} require #{package}:#{new_resource.version} #{dev} #{prefer_dist}"
    environment 'COMPOSER_HOME' => Composer.home_dir(node)
    action :run
    not_if do
      !version.include?('*') &&
        shell_out("cd #{new_resource.project_dir} && #{node['composer']['bin']} show #{package} #{version}").exitstatus == 0
    end
    user new_resource.user
    group new_resource.group
    umask new_resource.umask
  end
end

def remove_package(cmd)
  package = new_resource.package
  raise 'package is needed for composer_project with action require' if package.nil?
  version = new_resource.version ? new_resource.version : '*.*.*'

  execute "#{cmd}-composer-for-project" do
    cwd new_resource.project_dir
    command "#{node['composer']['bin']} remove #{package}"
    environment 'COMPOSER_HOME' => Composer.home_dir(node)
    action :run
    only_if "#{node['composer']['bin']} show #{package} #{version}"
  end
end

def optimize_flag(cmd)
  (%(install update).include? cmd) ? '--optimize-autoloader' : '--optimize'
end
