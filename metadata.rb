name             "composer"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures Composer"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.6"

%w{ debian ubuntu redhat centos fedora scientific amazon windows }.each do |os|
supports os
end

recommends "php"
recommends "windows"

recipe "composer", "Installs (if applicable) and self-updates composer."
recipe "composer::install", "Installs composer."
recipe "composer::self_update", "Installs (if applicable) and self-updates composer."