#
# Cookbook Name:: composer
# Provider:: composer
#
# Copyright 2012-2013, Escape Studios
#

def whyrun_supported?
    true
end

include_recipe "php"

action :install do
    #install/upgrade curl
    package "curl" do
        action :upgrade
    end

    command = "curl -s #{new_resource.url} | php"

    unless new_resource.install_globally
        unless new_resource.install_dir.nil? || new_resource.install_dir.empty?
          command = command + " -- --install-dir=#{new_resource.install_dir}"
        end
    end

    bash "download_composer" do
        cwd "#{Chef::Config[:file_cache_path]}"
        code <<-EOH
          #{command}
        EOH
        not_if "which composer"
    end

    if node[:composer][:install_globally]
        bash "move_composer" do
          cwd "#{Chef::Config[:file_cache_path]}"
          code <<-EOH
            sudo mv composer.phar #{node[:composer][:prefix]}/bin/composer
          EOH
          not_if "which composer"
        end
    end
end

action :self_update do
    if new_resource.install_globally
        wd = "#{Chef::Config[:file_cache_path]}"
        command = "sudo composer.phar"
    else
        wd = "#{new_resource.install_dir}"
        command = "php composer.phar"
    end

    command = command + " self-update"

    bash "update_composer" do
        cwd "#{wd}"
        code <<-EOH
          #{command}
        EOH
    end
end