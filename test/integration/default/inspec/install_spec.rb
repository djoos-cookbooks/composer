describe file('/usr/local/bin/composer') do
  it { should exist }
  its('mode') { should cmp '0755' }
end

describe command('composer --version') do
  its('stdout') { should match /Composer version/ }
end
