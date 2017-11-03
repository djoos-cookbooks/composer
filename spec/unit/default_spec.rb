require 'spec_helper'

describe 'composer::default' do
  before(:each) do
    stub_command("php -m | grep 'Phar'").and_return(true)
    stub_command('[[ $(/usr/local/bin/composer --version | grep 1.4.1 | wc -l) -eq 1 ]]')
  end

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'includes the install recipe' do
    expect(chef_run).to include_recipe('composer::install')
  end
end
