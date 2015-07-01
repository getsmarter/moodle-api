require 'typhoeus'

module Moodle
  class Client
    attr_reader :web_service_name, :filter_params

    # def initialize name, filter_params
    #   @name = name
    #   @filter_params = filter_params
    # end

    def method_missing message, *args, &block
      @web_service_name = message
      @filter_params = args.first

      if available_web_service? message
        resolve_request
      else
        super
      end
    end

    def available_web_service? name
      Moodle.configuration.available_web_services.include?(name.to_sym)
    end

    def make_request name, filter_params

    end

    def resolve_request
      request
      raise MoodleError, response["message"] if request_resulted_in_exception?
      response
    end

    def request
      @request ||= Typhoeus.post(Moodle.configuration.api_url,
                                 params: request_params,
                                 headers: { 'Accept' => "json" })
    end

    def response
      JSON.parse(request.body)
    end

    def request_resulted_in_exception?
      response['exception']
    end

    def request_params
      filter_params.merge!({ moodlewsrestformat: Moodle.configuration.format,
                             wsfunction: web_service_name,
                             wstoken: Moodle.configuration.token })
    end
  end
end
