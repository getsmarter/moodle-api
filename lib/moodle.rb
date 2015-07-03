require 'moodle/version'
require 'moodle/configuration'
require 'moodle/client'
require 'moodle/errors'

begin
  require 'pry'
rescue
  LoadError
end

module Moodle
  class << self
    attr_accessor :configuration

    def method_missing method_name, *args, &block
        @client = Moodle::Client.new.make_request(method_name, args.first)
    end

    def configure options = {}
      options.each { |key, value| configuration.instance_variable_set("@#{key}", value) }
      yield(configuration) if block_given?
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def reset_configuration
      configuration.reset
    end
  end
end
