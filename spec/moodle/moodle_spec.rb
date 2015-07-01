require 'spec_helper'

RSpec.describe Moodle do
  it 'allows the configuration to be setup using a block' do
    Moodle.configure do |c|
      c.host = 'http://example.com'
      c.token = '3209dlsdfj2n0s9'
    end

    expect(Moodle.configuration.host).to eq('http://example.com')
    expect(Moodle.configuration.token).to eq('3209dlsdfj2n0s9')
  end

   it 'allows resetting the configuration setup' do
    Moodle.reset_configuration

    expect(Moodle.configuration.host).to eq(nil)
    expect(Moodle.configuration.token).to eq(nil)
  end
end
