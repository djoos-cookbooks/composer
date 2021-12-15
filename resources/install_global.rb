#
# Cookbook:: composer
# Resource:: install_global
#
# Copyright:: 2012-2021, Escape Studios
#

unified_mode true
default_action :install

property :package, String, name_property: true
property :version, String, default: '*.*.*'
property :install_dir, String, default: lazy { node['composer']['global_install']['install_dir'] }
property :bin_dir, String, default: lazy { node['composer']['global_install']['bin_dir'] }
property :dev, [true, false], default: false
property :quiet, [true, false], default: true
property :optimize_autoloader, [true, false], default: false
property :prefer_dist, [true, false], default: false
property :prefer_source, [true, false], default: false

action :install do
  directory new_resource.install_dir

  composer_project new_resource.install_dir do
    package new_resource.package
    version new_resource.version
    bin_dir new_resource.bin_dir
    dev new_resource.dev
    quiet new_resource.quiet
    optimize_autoloader new_resource.optimize_autoloader
    prefer_dist new_resource.prefer_dist
    prefer_source new_resource.prefer_source
    action :require
  end
end

action :remove do
  composer_project new_resource.install_dir do
    package new_resource.package
    version new_resource.version
    bin_dir new_resource.bin_dir
    dev new_resource.dev
    quiet new_resource.quiet
    optimize_autoloader new_resource.optimize_autoloader
    prefer_dist new_resource.prefer_dist
    prefer_source new_resource.prefer_source
    action :remove
  end
end

action :update do
  composer_project new_resource.install_dir do
    package new_resource.package
    version new_resource.version
    bin_dir new_resource.bin_dir
    dev new_resource.dev
    quiet new_resource.quiet
    optimize_autoloader new_resource.optimize_autoloader
    prefer_dist new_resource.prefer_dist
    prefer_source new_resource.prefer_source
    action :update
  end
end
