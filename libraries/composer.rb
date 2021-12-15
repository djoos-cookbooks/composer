module Composer
  module Cookbook
    module Helpers
      def composer_install_dir(node)
        node['composer']['install_dir']
      end

      def composer_home_dir(node)
        node['composer']['home_dir'] || install_dir(node)
      end
    end
  end
end

Chef::DSL::Recipe.include ::Composer::Cookbook::Helpers
Chef::Resource.include ::Composer::Cookbook::Helpers
