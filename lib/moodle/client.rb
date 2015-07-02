require 'typhoeus'
require 'json'

module Moodle
  class Client
    attr_reader :web_service_name, :filter_params

    def make_request web_service_name, filter_params = {}
      @web_service_name = web_service_name
      @filter_params = filter_params

      if available_web_service?(web_service_name)
        request
        raise_response_exceptions
        response
      else
        raise_service_restriction_exception
      end
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

    def raise_service_restriction_exception
      message = "Ensure the web service is available - check Moodle.configuration.available_web_services"
      raise ServiceRestrictionError, message
    end

    def request_resulted_in_exception?
      response.is_a?(Hash) && response['exception'] # exceptions should always be in a hash
    end

    def request_params
      filter_params.merge!({ moodlewsrestformat: Moodle.configuration.format,
                             wsfunction: web_service_name,
                             wstoken: Moodle.configuration.token })
    end

    def available_web_service? name
      Moodle.configuration.available_web_services.include?(name.to_sym)
    end
  end
end
