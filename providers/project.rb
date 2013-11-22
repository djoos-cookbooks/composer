#
# Cookbook Name:: composer
# Resource:: project
#
# Copyright 2012-2013, Escape Studios
#

def whyrun_supported?
    true
end

dev = new_resource.dev ? "--dev" : "--no-dev"
quiet = new_resource.quiet ? "--quiet" : ""

action :install do
    command "composer install --no-interaction --no-ansi #{quiet} #{dev}"
end

action :update do
    command "composer update --no-interaction --no-ansi #{quiet} #{dev}"
end

action :dump_autoload do
    command "composer dump-autoload --no-interaction --no-ansi #{quiet} #{dev}"
end

execute "composer_project" do
    cwd "#{new_resource.project_dir}"

    command "#{command}"
    only_if "which composer"
end