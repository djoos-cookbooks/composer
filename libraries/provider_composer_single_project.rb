require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class ComposerSingleProject < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      action :require do
        path = new_resource.path
        vendor = new_resource.vendor
        dev = new_resource.dev ? '--dev' : '--update-no-dev'
        prefer_dist = new_resource.prefer_dist ? '--prefer-dist' : ''

        execute 'composer require for project' do
          cwd path
          command "#{node['composer']['bin']} require #{vendor} #{dev} #{prefer_dist}"
          environment 'COMPOSER_HOME' => Composer.home_dir(node)
          action :run
          only_if 'which composer'
          user new_resource.user
          group new_resource.group
          umask new_resource.umask
        end
      end

      action :install do
        path = new_resource.path
        vendor = new_resource.vendor
        dev = new_resource.dev ? '--dev' : '--update-no-dev'
        prefer_dist = new_resource.prefer_dist ? '--prefer-dist' : ''

        execute 'composer require for project' do
          cwd path
          command "#{node['composer']['bin']} require #{vendor} #{dev} #{prefer_dist}"
          environment 'COMPOSER_HOME' => Composer.home_dir(node)
          action :run
          only_if 'which composer'
          user new_resource.user
          group new_resource.group
          umask new_resource.umask
        end

        execute 'composer install for project' do
          cwd path
          command "#{node['composer']['bin']} install"
          environment 'COMPOSER_HOME' => Composer.home_dir(node)
          action :run
          only_if 'which composer'
          user new_resource.user
          group new_resource.group
          umask new_resource.umask
        end
      end
    end
  end
end
