require 'moodle/version'
require 'moodle/configuration'
require 'moodle/client'
require 'moodle/errors'
require 'moodle/token_generator'
require 'moodle/request'

begin
  require 'pry'
rescue
  LoadError
end

module Moodle
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
      @client ||= Moodle::Client.new
    end
  end
end
