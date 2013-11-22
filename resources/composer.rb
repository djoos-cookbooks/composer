#
# Cookbook Name:: composer
# Resource:: composer
#
# Copyright 2012-2013, Escape Studios
#

actions :install, :self_update
default_action :install

attribute :install_globally, :kind_of => [TrueClass, FalseClass], :default => true
attribute :prefix, :kind_of => String, :default => "/usr/local"
attribute :url, :kind_of => String, :default => "https://getcomposer.org/installer"
attribute :install_dir, :kind_of => String, :default => nil, :name_attribute => true

def initialize(*args)
    super
    @action = :install
end