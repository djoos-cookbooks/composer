#
# Cookbook Name:: composer
# Resource:: project
#
# Copyright 2012-2014, Escape Studios
#

actions :install, :update, :dump_autoload
default_action :install

attribute :project_dir,         :kind_of => String, :name_attribute => true
attribute :dev,                 :kind_of => [TrueClass, FalseClass], :default => false
attribute :quiet,               :kind_of => [TrueClass, FalseClass], :default => true
attribute :optimize_autoloader, :kind_of => [TrueClass, FalseClass], :default => false
attribute :prefer_dist,         :kind_of => [TrueClass, FalseClass], :default => false
attribute :code,                :kind_of => String
attribute :user,                :kind_of => String, :default => 'root'
attribute :group,               :kind_of => String, :default => 'root'
attribute :creates,             :kind_of => String
attribute :path,                :kind_of => Array
attribute :returns,             :kind_of => Array, :default => [ 0 ]
attribute :timeout,             :kind_of => Integer
attribute :umask,               :kind_of => [String, Fixnum], :default => 0002
attribute :environment,         :kind_of => Hash

def initialize(*args)
  super
  @action = :install
end
