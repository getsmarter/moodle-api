module Moodle
  class Configuration
    attr_accessor :host,
    :token,
    :format,
    :api_url

    DEFAULT_FORMAT = :json

    DEFAULT_WEB_SERVICES = []

    DEFAULT_API_URL = '/webservice/rest/server.php'

    def initialize
      @format = DEFAULT_FORMAT
    end

    def reset
      @host = nil
      @token = nil
      @format = DEFAULT_FORMAT
    end

    def api_url
      "#{host}#{DEFAULT_API_URL}"
    end
  end
end
