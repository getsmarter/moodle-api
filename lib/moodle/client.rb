require 'typhoeus'
require 'json'

module Moodle
  class Client
    attr_reader :web_service_name, :filter_params

    def make_request web_service_name, filter_params = {}
      @web_service_name = web_service_name
      @filter_params = filter_params

      request
      raise_response_exceptions
      response
    end

    private

    def request
      @request ||= Typhoeus.post(Moodle.configuration.api_url,
                                 params: request_params,
                                 headers: { 'Accept' => "json" })
    end

    def raise_response_exceptions
      if request_resulted_in_exception?
        message = response["message"]
        raise MoodleError, message
      end
    end

    def response
      JSON.parse(request.body)
    end

    def request_resulted_in_exception?
      # exceptions should always be in a hash and have the key 'exception'
      response.is_a?(Hash) && response['exception']
    end

    def request_params
      filter_params.merge!({ moodlewsrestformat: Moodle.configuration.format,
                             wsfunction: web_service_name,
                             wstoken: Moodle.configuration.token })
    end
  end
end
