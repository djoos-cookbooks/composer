#
# Cookbook:: composer
# Resource:: project
#
# Copyright:: 2016-2021, David Joos
#

unified_mode true
default_action :install

property :project_dir, String, name_property: true
property :vendor, String
property :package, String
property :version, String
property :dev, [true, false], default: false
property :quiet, [true, false], default: true
property :optimize_autoloader, [true, false], default: false
property :prefer_dist, [true, false], default: false
property :prefer_source, [true, false], default: false
property :bin_dir, String, default: 'vendor/bin'
property :user, String, default: 'root'
property :group, String, default: 'root'
property :umask, [String, Integer], default: '0002'
property :environment, Hash, default: {}

action :install do
  make_execute 'install'
end

action :require do
  make_require
end

action :update do
  make_execute 'update'
end

action :dump_autoload do
  make_execute 'dump-autoload'
end

action :remove do
  remove_package 'remove'
end

action_class do
  def make_execute(cmd)
    dev = new_resource.dev ? '--dev' : '--no-dev'
    quiet = new_resource.quiet ? '--quiet' : ''
    optimize = new_resource.optimize_autoloader ? optimize_flag(cmd) : ''
    prefer_dist = new_resource.prefer_dist ? '--prefer-dist' : ''
    prefer_source = new_resource.prefer_source ? '--prefer-source' : ''
    environment = {
      COMPOSER_HOME: composer_home_dir(node),
      COMPOSER_BIN_DIR: new_resource.bin_dir,
    }

    execute "#{cmd}-composer-for-project" do
      cwd new_resource.project_dir
      command "#{node['composer']['bin']} #{cmd} --no-interaction --no-ansi #{quiet} #{dev} #{optimize} #{prefer_dist} #{prefer_source}"
      environment(environment.merge(new_resource.environment))
      action :run
      user new_resource.user
      group new_resource.group
      umask new_resource.umask
    end
  end

  def make_require
    dev = new_resource.dev ? '--dev' : '--update-no-dev'
    package = new_resource.package
    version = new_resource.version || '*.*.*'
    package, version = vendor_package_identity(new_resource.vendor, package, version)
    raise 'package is needed for composer_project with action require' if package.nil?
    prefer_dist = new_resource.prefer_dist ? '--prefer-dist' : ''
    environment = {
      COMPOSER_HOME: composer_home_dir(node),
      COMPOSER_BIN_DIR: new_resource.bin_dir,
    }

    execute 'Install-composer-for-single-project' do
      cwd new_resource.project_dir
      command "#{node['composer']['bin']} require #{package}:#{version} #{dev} #{prefer_dist}"
      environment(environment.merge(new_resource.environment))
      action :run
      not_if do
        !version.include?('*') &&
          shell_out("cd #{new_resource.project_dir} && #{node['composer']['bin']} show #{package} #{version}").exitstatus.zero?
      end
      user new_resource.user
      group new_resource.group
      umask new_resource.umask
    end
  end

  def remove_package(cmd)
    package = new_resource.package
    version = new_resource.version || '*.*.*'
    package, version = vendor_package_identity(new_resource.vendor, package, version)
    raise 'package is needed for composer_project with action require' if package.nil?
    environment = {
      COMPOSER_HOME: composer_home_dir(node),
      COMPOSER_BIN_DIR: new_resource.bin_dir,
    }

    execute "#{cmd}-composer-for-project" do
      cwd new_resource.project_dir
      command "#{node['composer']['bin']} remove #{package}"
      environment(environment.merge(new_resource.environment))
      action :run
      only_if "#{node['composer']['bin']} show #{package} #{version}"
    end
  end

  def optimize_flag(cmd)
    %(install update).include?(cmd) ? '--optimize-autoloader' : '--optimize'
  end

  def vendor_package_identity(vendor, package, version)
    unless vendor.nil?
      # @todo take out deprecated vendor logic
      Chef::Log.warn('The vendor attribute is deprecated, please use package and version instead.')

      vendor_split = vendor.split(':')
      package = vendor_split[0]

      version = if vendor_split[1].nil?
                  version
                else
                  vendor_split[1]
                end
    end

    [package, version]
  end
end
