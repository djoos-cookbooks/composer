#
# Cookbook Name:: composer
# Recipe:: global_configs
#
# Copyright 2012-2014, Escape Studios
#

configs = node['composer']['global_configs']

unless configs.nil?
    configs.each_pair do |user,user_configs|
        directory "/home/#{user}/.composer" do
          owner user
          group user
          mode 0755
        end
        unless user_configs.nil?
            user_configs.each_pair do |option,value|
                if value.respond_to?(:each_pair)
                    value.each_pair do |value_k,value_v|
                        execute "composer-config-for-#{user}" do
                            command "composer config --global #{option}.#{value_k} #{value_v}"
                            user user
                            group user
                            action :run
                        end
                    end
                else
                    execute "composer-config-for-#{user}" do
                        command "composer config --global #{option} #{value}"
                        user user
                        group user
                        action :run
                    end
                end
            end
        end
    end
end