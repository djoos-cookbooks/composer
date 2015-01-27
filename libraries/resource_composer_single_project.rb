# encoding: UTF-8
require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class ComposerSingleProject < Chef::Resource::LWRPBase
      self.resource_name = :composer_single_project
      actions :install, :require
      default_action :install

      attribute :vendor, :kind_of => String, :name_attribute => true, :required => true
      attribute :path, :kind_of => String, :default => nil
      attribute :dev, :kind_of => [TrueClass, FalseClass], :default => false
      attribute :prefer_dist, :kind_of => [TrueClass, FalseClass], :default => false
      attribute :user, :kind_of => String, :default => 'root'
      attribute :group, :kind_of => String, :default => 'root'
      attribute :umask, :kind_of => [String, Fixnum], :default => 0002
    end
  end
end
