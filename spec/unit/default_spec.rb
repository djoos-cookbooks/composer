require 'spec_helper'

describe 'composer::default' do
  before(:each) do
    stub_command("php -m | grep 'Phar'").and_return(true)
  end

  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the self_update recipe' do
    expect(chef_run).to include_recipe('composer::install')
  end
end
