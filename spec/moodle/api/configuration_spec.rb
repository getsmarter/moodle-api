require 'spec_helper'

module Moodle
  # Tests Configuration
  module Api
    RSpec.describe Configuration do
      let(:configuration) do
        configuration = Configuration.new
        configuration.host = 'http://example.com'
        configuration.username = 'jonsnow'
        configuration.password = 'batman'
        configuration.service = 'service'
        configuration.token = '183jdmsoa82jasnd'
        configuration.format = :xml
        configuration
      end

      it '#host' do
        expect(configuration.host).to eq('http://example.com')
      end

      it '#username' do
        expect(configuration.username).to eq('jonsnow')
      end

      it '#password' do
        expect(configuration.password).to eq('batman')
      end

      it '#service' do
        expect(configuration.service).to eq('service')
      end

      it '#token' do
        expect(configuration.token).to eq('183jdmsoa82jasnd')
      end

      it '#format defaults to json' do
        expect(configuration.format).to eq(:xml)
      end

      it '#web_service_api_url' do
        url = 'http://example.com/webservice/rest/server.php'
        expect(configuration.web_service_api_url).to eq(url)
      end

      it '#token_api_url' do
        url = 'http://example.com/login/token.php'
        expect(configuration.token_api_url).to eq(url)
      end

      it '#reset' do
        configuration.reset

        expect(configuration.host).to eq(nil)
        expect(configuration.username).to eq(nil)
        expect(configuration.password).to eq(nil)
        expect(configuration.service).to eq(nil)
        expect(configuration.format).to eq(:json)
      end

      it 'raises ArgumentError if username and password are not present and the token is requested' do
        configuration.reset

        e = 'Username and password are required to generate a token'

        expect do
          configuration.token
        end.to raise_error(ArgumentError, e)
      end

      it 'allows configuration via options' do
        configuration = Configuration.new(host: 'host', token: 'token')
        expect(configuration.host).to eq('host')
        expect(configuration.token).to eq('token')
      end

      it 'allows configuration via config method options' do
        configuration = Configuration.new
        configuration.configure(host: 'host', token: 'token')

        expect(configuration.host).to eq('host')
        expect(configuration.token).to eq('token')
      end

      it 'allows configuration via config block' do
        configuration = Configuration.new
        configuration.configure do |c|
          c.host = 'host'
          c.token = 'token'
        end

        expect(configuration.host).to eq('host')
        expect(configuration.token).to eq('token')
      end

      it 'retrieves a token if one was not set' do
        token_service = double(:service, call: 'token')
        configuration.token_service = token_service
        configuration.token = nil
        expect(configuration.token).to eq('token')
        expect(token_service).to have_received(:call)
      end
    end
  end
end
