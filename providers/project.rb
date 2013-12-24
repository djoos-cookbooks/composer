#
# Cookbook Name:: composer
# Resource:: project
#
# Copyright 2012-2013, Escape Studios
#

use_inline_resources

def whyrun_supported?
    true
end

action :install do
    dev = new_resource.dev ? "--dev" : "--no-dev"
    quiet = new_resource.quiet ? "--quiet" : ""

    execute "install-composer-for-project" do
        cwd new_resource.project_dir
        command "#{node['composer']['bin']} install --no-interaction --no-ansi #{quiet} #{dev}"
        action :run
        only_if "which composer"

    end
end

action :update do
    dev = new_resource.dev ? "--dev" : "--no-dev"
    quiet = new_resource.quiet ? "--quiet" : ""

    execute "update-composer-for-project" do
        cwd new_resource.project_dir
        command "#{node['composer']['bin']} update --no-interaction --no-ansi #{quiet} #{dev}"
        action :run
        only_if "which composer"
    end
end

action :dump_autoload do
    dev = new_resource.dev ? "--dev" : "--no-dev"
    quiet = new_resource.quiet ? "--quiet" : ""

    execute "dump-autoload-composer-for-project" do
        cwd new_resource.project_dir
        command "#{node['composer']['bin']} dump-autoload --no-interaction --no-ansi #{quiet} #{dev}"
        action :run
        only_if "which composer"
    end
end