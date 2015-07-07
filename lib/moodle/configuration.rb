module Moodle
  class Configuration
    attr_writer :token_service
    attr_accessor :host,
      :username,
      :password,
      :service,
      :token,
      :format

    DEFAULT_FORMAT = :json

    DEFAULT_WEB_SERVICE_API_URL = '/webservice/rest/server.php'

    DEFAULT_TOKEN_API_URL = '/login/token.php'

    def initialize options = {}
      @format = DEFAULT_FORMAT

      configure(options)
    end

    def reset
      @host = nil
      @username = nil
      @password = nil
      @service = nil
      @token = nil
      @format = DEFAULT_FORMAT
    end

    def web_service_api_url
      "#{host}#{DEFAULT_WEB_SERVICE_API_URL}"
    end

    def token_api_url
      "#{host}#{DEFAULT_TOKEN_API_URL}"
    end

    def configure options = {}, &block
      options.each { |key, value| instance_variable_set("@#{key}", value) }
      block.call(self) if block_given?
    end

    def token
      raise ArgumentError, 'Username and password are required to generate a token' if raise_token_exception?
      @token ||= token_service.call # if not set use token service
    end

    def raise_token_exception?
      @token.nil? && (username.nil? || password.nil?)
    end

    def token_service
      @token_service ||= TokenGenerator.new(self)
    end
  end
end
