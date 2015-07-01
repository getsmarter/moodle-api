module Moodle
  class Configuration
    attr_accessor :host,
    :token,
    :format,
    :available_web_services,
    :api_url

    DEFAULT_FORMAT = :json

    DEFAULT_WEB_SERVICES = []

    DEFAULT_API_URL = '/webservice/rest/server.php'

    def initialize
      @format = DEFAULT_FORMAT
      @available_web_services = DEFAULT_WEB_SERVICES
    end

    def reset
      @host = nil
      @token = nil
      @format = DEFAULT_FORMAT
      @available_web_services = DEFAULT_WEB_SERVICES
    end

    def api_url
      "#{host}#{DEFAULT_API_URL}"
    end
  end
end
