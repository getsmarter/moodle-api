module Moodle
  class TokenGenerator
    attr_reader :configuration

    def initialize configuration
      @configuration = configuration
    end

    def call
      generate_token
    end

    private

    def generate_token
      Request.new.post(configuration.token_api_url,
                       params: request_params,
                       headers: { 'Accept' => "json" })
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
