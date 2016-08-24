require 'serverspec'

describe file('/usr/local/bin/composer') do
  it { should be_file }
  it { should be_mode 755 }
end
