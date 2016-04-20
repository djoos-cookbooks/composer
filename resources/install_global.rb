#
# Cookbook Name:: composer
# Resource:: install_global
#
# Copyright 2012-2014, Escape Studios
#

actions :install, :update, :remove
default_action :install

attribute :vendor, :kind_of => String, :name_attribute => true, :required => true
attribute :install_dir, :kind_of => String
attribute :path, :kind_of => String, :default => nil
attribute :dev, :kind_of => [TrueClass, FalseClass], :default => false
attribute :quiet, :kind_of => [TrueClass, FalseClass], :default => true
attribute :optimize_autoloader, :kind_of => [TrueClass, FalseClass], :default => false
attribute :prefer_dist, :kind_of => [TrueClass, FalseClass], :default => false
attribute :prefer_source, :kind_of => [TrueClass, FalseClass], :default => false
attribute :user, :kind_of => String, :default => 'root'
attribute :group, :kind_of => String, :default => 'root'
attribute :umask, :kind_of => [String, Fixnum], :default => 0002

def initialize(*args)
  super
  @action = :install
end
