require 'serverspec'
set :backend, :exec
set :path, '/sbin:/usr/sbin:/usr/local/sbin:$PATH'

describe command('php -v') do
  its(:stdout) { should match('PHP 5.') }
end

describe command("php -m | grep 'Phar'") do
  its(:stdout) { should match 'Phar' }
end

describe file('/usr/local/bin/composer') do
  it { should be_file }
  it { should be_mode 755 }
end
