require 'serverspec'

set :backend, :exec

# these vars must correspond with attributes' values
composer_install_path = '/usr/local/bin'
composer_version = '1.3.2'

describe file("#{composer_install_path}/composer") do
  it { should be_file }
  it { should be_mode 755 }
end

describe command("#{composer_install_path}/composer") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain "Composer version #{composer_version}" }
end
