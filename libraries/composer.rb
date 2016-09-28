# Composer module
module Composer
  def self.install_dir(node)
    node['composer']['install_dir']
  end

  def self.home_dir(node)
    node['composer']['home_dir'] || install_dir(node)
  end

  def self.bin_dir(node)
    node['composer']['bin_dir'] || ''
  end
end
