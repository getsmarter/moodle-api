require 'json'
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

    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def reset_configuration
      configuration.reset
    end
  end
end
