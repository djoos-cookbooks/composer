if defined?(ChefSpec)
  # install
  def install_composer_single_project(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:composer_single_project, :install, resource_name)
  end

  # require
  def require_composer_single_project(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:composer_single_project, :require, resource_name)
  end
end
