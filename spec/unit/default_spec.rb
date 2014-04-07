require 'spec_helper'

describe 'composer::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the self_update recipe' do
    expect(chef_run).to include_recipe('composer::self_update')
  end
end
