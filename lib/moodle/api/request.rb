require 'typhoeus'
require 'json'

module Moodle
  module Api
    class Request
      attr_reader :response

      def post path,  options = {}
        @response = Typhoeus.post(path, options)
        resolve_response if response.success?
      end

      private

      def resolve_response
        response_body unless request_raised_exception?
      end

      def request_raised_exception?
        if external_services_api_exception?
          raise MoodleError, response_body["message"]
        elsif token_service_api_exception?
          raise MoodleError, response_body["error"]
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

      def response_body
        JSON.parse(response.body)
      end
    end
  end
end
