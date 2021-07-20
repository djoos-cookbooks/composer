require 'spec_helper'

describe 'composer::default' do
  platform 'ubuntu'

  before do
    stub_command("php -m | grep 'Phar'").and_return(true)
  end

  it do
    expect(chef_run).to include_recipe('composer::install')
  end
end
