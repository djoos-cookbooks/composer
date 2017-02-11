require 'serverspec'

describe file('/usr/local/bin/composer') do
  it { should be_file }
  it { should be_mode 755 }
end

describe command('/usr/local/bin/composer') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain 'Composer version 1.3.2' }
end
