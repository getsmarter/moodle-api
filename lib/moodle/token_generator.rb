module Moodle
  class TokenGenerator
    attr_reader :configuration

    def initialize configuration
      @configuration = configuration
    end

    def call
      raise ArgumentError, 'Username and password are required to generate a token' if raise_token_exception?
      generate_token
    end

    private

    def generate_token
      response = Request.new.post(configuration.token_api_url,
                                  params: request_params,
                                  headers: { 'Accept' => "json" })
      response['token']
    end

    def raise_token_exception?
      configuration.username.nil? || configuration.password.nil?
    end

    def request_params
      {
        username: configuration.username,
        password: configuration.password,
        service: configuration.service
      }
    end
  end
end
