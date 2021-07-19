require 'typhoeus'
require 'json'

module Moodle
  module Api
    # Handles making the request to the Moodle API and interpreting the
    # results. The Moodle API is not consistent in the way it returns
    # responses so the type of response is determined, successful responses
    # are returned, failures are parsed and raised in a generic fashion.
    class Request
      attr_reader :response
      attr_accessor :options

      def post(path,  options = {})
        @options  = options
        @response = Typhoeus.post(path, options)
        resolve_response if response.success?
      end

      private

      def resolve_response
        response_body unless request_raised_exception?
      end

      def request_raised_exception?
        if external_services_api_exception?
          fail MoodleError, external_services_api_error_message
        elsif token_service_api_exception?
          fail MoodleError, response_body['error']
        end
      end

      def exception_raised?
        external_services_api_exception? && token_service_api_exception?
      end

      def external_services_api_exception?
        response_body.is_a?(Hash) && response_body['exception']
      end

      def token_service_api_exception?
        response_body.is_a?(Hash) && response_body['error']
      end

      def external_services_api_error_message
        function = @options.dig(:params, :wsfunction) || 'unknown_function'
        [function, response_body['message'], response_body['debuginfo']].compact.join(' - ')
      end

      # API calls that return null are considered successful
      def response_body
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    end
  end
end
