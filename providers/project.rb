#
# Cookbook Name:: composer
# Resource:: project
#
# Copyright 2012-2014, Escape Studios
#

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :install do
  make_execute 'install'
  new_resource.updated_by_last_action(true)
end

action :update do
  make_execute 'update'
  new_resource.updated_by_last_action(true)
end

action :dump_autoload do
  make_execute 'dump-autoload'
  new_resource.updated_by_last_action(true)
end

private

def make_execute(cmd)
  script_code         = build_script_code(cmd)
  script_environment  = build_script_environment(cmd)

  script "#{cmd}-composer-for-project" do
    interpreter "bash"
    cwd         new_resource.project_dir
    code        script_code
    action      :run
    only_if     'which composer'
    user        new_resource.user     if new_resource.user
    creates     new_resource.creates  if new_resource.creates
    group       new_resource.group    if new_resource.group
    path        new_resource.path     if new_resource.path
    returns     new_resource.returns  if new_resource.returns
    timeout     new_resource.timeout  if new_resource.timeout
    umask       new_resource.umask    if new_resource.umask
    environment(script_environment)
  end
end

def optimize_flag(cmd)
  %(install update).include? cmd ? '--optimize-autoloader' : '--optimize'
end

def build_script_code(cmd)
  dev = new_resource.dev ? '--dev' : '--no-dev'
  quiet = new_resource.quiet ? '--quiet' : ''
  optimize = new_resource.optimize_autoloader ? optimize_flag(cmd) : ''
  prefer_dist = new_resource.prefer_dist ? '--prefer-dist' : ''

  script = []
  script << new_resource.code
  script << %{#{node['composer']['bin']} #{cmd} --no-interaction --no-ansi #{quiet} #{dev} #{optimize} #{prefer_dist}}
  script.join("\n")
end

def build_script_environment
  script_env = { 'COMPOSER_HOME' => node['composer']['install_dir'] }
  if new_resource.environment
    script_env.merge!(new_resource.environment)
  end
  script_env
end
