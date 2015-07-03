require 'spec_helper'

module Moodle
  RSpec.describe Configuration do
    let(:configuration) do
      configuration = Configuration.new
      configuration.host = 'http://example.com'
      configuration.token = '183jdmsoa82jasnd'
      configuration.format = :xml
      configuration
    end

    it '#host' do
      expect(configuration.host).to eq('http://example.com')
    end

    it '#token' do
      expect(configuration.token).to eq('183jdmsoa82jasnd')
    end

    it '#format defaults to json' do
      expect(configuration.format).to eq(:xml)
    end

    it '#api_url' do
      expect(configuration.api_url).to eq('http://example.com/webservice/rest/server.php')
    end

    it '#reset' do
      configuration.reset

      expect(configuration.host).to eq(nil)
      expect(configuration.token).to eq(nil)
      expect(configuration.format).to eq(:json)
    end
  end
end
