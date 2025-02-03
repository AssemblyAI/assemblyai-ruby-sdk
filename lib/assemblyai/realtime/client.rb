# frozen_string_literal: true

require_relative "../../requests"
require_relative "types/realtime_temporary_token_response"
require "async"

module AssemblyAI
  class RealtimeClient
    # @return [AssemblyAI::RequestClient]
    attr_reader :request_client

    # @param request_client [AssemblyAI::RequestClient]
    # @return [AssemblyAI::RealtimeClient]
    def initialize(request_client:)
      @request_client = request_client
    end

    # Create a temporary authentication token for Streaming Speech-to-Text
    #
    # @param expires_in [Integer] The amount of time until the token expires in seconds
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Realtime::RealtimeTemporaryTokenResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.realtime.create_temporary_token(expires_in: 480)
    def create_temporary_token(expires_in:, request_options: nil)
      response = @request_client.conn.post do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = {
      **(req.headers || {}),
      **@request_client.get_headers,
      **(request_options&.additional_headers || {})
        }.compact
        unless request_options.nil? || request_options&.additional_query_parameters.nil?
          req.params = { **(request_options&.additional_query_parameters || {}) }.compact
        end
        req.body = { **(request_options&.additional_body_parameters || {}), expires_in: expires_in }.compact
        req.url "#{@request_client.get_url(request_options: request_options)}/v2/realtime/token"
      end
      AssemblyAI::Realtime::RealtimeTemporaryTokenResponse.from_json(json_object: response.body)
    end
  end

  class AsyncRealtimeClient
    # @return [AssemblyAI::AsyncRequestClient]
    attr_reader :request_client

    # @param request_client [AssemblyAI::AsyncRequestClient]
    # @return [AssemblyAI::AsyncRealtimeClient]
    def initialize(request_client:)
      @request_client = request_client
    end

    # Create a temporary authentication token for Streaming Speech-to-Text
    #
    # @param expires_in [Integer] The amount of time until the token expires in seconds
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Realtime::RealtimeTemporaryTokenResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.realtime.create_temporary_token(expires_in: 480)
    def create_temporary_token(expires_in:, request_options: nil)
      Async do
        response = @request_client.conn.post do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = {
        **(req.headers || {}),
        **@request_client.get_headers,
        **(request_options&.additional_headers || {})
          }.compact
          unless request_options.nil? || request_options&.additional_query_parameters.nil?
            req.params = { **(request_options&.additional_query_parameters || {}) }.compact
          end
          req.body = { **(request_options&.additional_body_parameters || {}), expires_in: expires_in }.compact
          req.url "#{@request_client.get_url(request_options: request_options)}/v2/realtime/token"
        end
        AssemblyAI::Realtime::RealtimeTemporaryTokenResponse.from_json(json_object: response.body)
      end
    end
  end
end
