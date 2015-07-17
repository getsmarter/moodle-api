require 'spec_helper'

module Moodle
  # Tests TokenGenerator
  module Api
    RSpec.describe TokenGenerator do
      let(:configuration) do
        configuration = Configuration.new
        configuration.configure do |c|
          c.host = 'http://my_moodle_instance.com'
          c.username = 'ryan.mes@email.co.za'
          c.password = 'mypassword'
          c.service = 'phoenix_integration'
        end
        configuration
      end

      it 'generates a token' do
        VCR.use_cassette('token_service/token_service') do
          token = TokenGenerator.new(configuration).call
          expect(token).to eq('mytoken')
        end
      end

      it 'raises a moodle error when an invalid service is used' do
        configuration.service = 'invalidservice'

        e = 'Web service is not available (it doesn\'t exist or might be disabled)'

        VCR.use_cassette('token_service/invalid_service_token_service') do
          expect do
            TokenGenerator.new(configuration).call
          end.to raise_error(MoodleError, e)
        end
      end

      it 'raises a moodle error when an invalid user is used' do
        configuration.username = 'invalidusername'

        e = 'The username was not found in the database'

        VCR.use_cassette('token_service/invalid_username_token_service') do
          expect do
            TokenGenerator.new(configuration).call
          end.to raise_error(MoodleError, e)
        end
      end

      it 'raises a moodle error when an invalid password is used' do
        VCR.use_cassette('token_service/invalid_password_token_service') do
          configuration.password = 'invalidpassword'

          e = 'The username was not found in the database'

          expect do
            TokenGenerator.new(configuration).call
          end.to raise_error(MoodleError, e)
        end
      end

      it 'raises an argument error when username is not passed in' do
        configuration.username = nil

        e = 'Username and password are required to generate a token'

        expect do
          TokenGenerator.new(configuration).call
        end.to raise_error(ArgumentError, e)
      end

      it 'raises an argument error when password is not passed in' do
        configuration.password = nil

        e = 'Username and password are required to generate a token'

        expect do
          TokenGenerator.new(configuration).call
        end.to raise_error(ArgumentError, e)
      end
    end
  end
end
