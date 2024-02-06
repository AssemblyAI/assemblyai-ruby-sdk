# frozen_string_literal: true

require_relative "../../requests"
require_relative "types/realtime_temporary_token_response"
require "async"

module AssemblyAI
  class RealtimeClient
    attr_reader :request_client

    # @param request_client [RequestClient]
    # @return [RealtimeClient]
    def initialize(request_client:)
      # @type [RequestClient]
      @request_client = request_client
    end

    # Create a temporary authentication token for real-time transcription
    #
    # @param expires_in [Integer] The amount of time until the token expires in seconds
    # @param request_options [RequestOptions]
    # @return [Realtime::RealtimeTemporaryTokenResponse]
    def create_temporary_token(expires_in:, request_options: nil)
      response = @request_client.conn.post("/v2/realtime/token") do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
        req.body = { **(request_options&.additional_body_parameters || {}), expires_in: expires_in }.compact
      end
      Realtime::RealtimeTemporaryTokenResponse.from_json(json_object: response.body)
    end
  end

  class AsyncRealtimeClient
    attr_reader :request_client

    # @param request_client [AsyncRequestClient]
    # @return [AsyncRealtimeClient]
    def initialize(request_client:)
      # @type [AsyncRequestClient]
      @request_client = request_client
    end

    # Create a temporary authentication token for real-time transcription
    #
    # @param expires_in [Integer] The amount of time until the token expires in seconds
    # @param request_options [RequestOptions]
    # @return [Realtime::RealtimeTemporaryTokenResponse]
    def create_temporary_token(expires_in:, request_options: nil)
      Async do
        response = @request_client.conn.post("/v2/realtime/token") do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
          req.body = { **(request_options&.additional_body_parameters || {}), expires_in: expires_in }.compact
        end
        Realtime::RealtimeTemporaryTokenResponse.from_json(json_object: response.body)
      end
    end
  end
end
