require 'moodle/api/version'
require 'moodle/api/configuration'
require 'moodle/api/client'
require 'moodle/api/errors'
require 'moodle/api/token_generator'
require 'moodle/api/request'

module Moodle
  # Handles instantiating the client and determining how
  # method calls should be delegated to the client
  module Api
    class << self
      def method_missing(method, *args, &block)
        if client.respond_to?(method)
          client.send(method, *args, &block)
        else
          # assume method name is moodle external service
          client.make_request(method, args.first)
        end
      end

      def respond_to?(method, include_all = false)
        client.respond_to?(method, include_all) || super
      end

      def client
        @client ||= Moodle::Api::Client.new
      end
    end
  end
end
