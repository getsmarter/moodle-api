require 'moodle/api/version'
require 'moodle/api/configuration'
require 'moodle/api/client'
require 'moodle/api/errors'
require 'moodle/api/token_generator'
require 'moodle/api/request'

begin
  require 'pry'
rescue
  LoadError
end

module Moodle
  module Api
    class << self
      def method_missing method, *args, &block
        if client.respond_to?(method)
          client.send(method, *args, &block)
        else
          client.make_request(method, args.first) # assume method name is moodle external service
        end
      end

      def respond_to?(method, include_all=false)
        return client.respond_to?(method, include_all) || super
      end

      def client
        @client ||= Moodle::Api::Client.new
      end
    end
  end
end
