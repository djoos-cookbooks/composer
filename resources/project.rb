#
# Cookbook Name:: composer
# Resource:: project
#
# Copyright 2012-2013, Escape Studios
#

actions :install, :update, :dump_autoload
default_action :install

attribute :project_dir, :kind_of => String, :name_attribute => true
attribute :dev, :equal_to => [TrueClass, FalseClass], :default => false
attribute :quiet, :equal_to => [TrueClass, FalseClass], :default => true

def initialize(*args)
    super
    @action = :install
end