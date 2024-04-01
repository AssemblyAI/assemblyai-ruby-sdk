# frozen_string_literal: true

require_relative "environment"
require "faraday"
require "faraday/retry"
require "async/http/faraday"

module AssemblyAI
  class RequestClient
    attr_reader :headers, :base_url, :conn

    # @param environment [Environment]
    # @param max_retries [Long] The number of times to retry a failed request, defaults to 2.
    # @param timeout_in_seconds [Long]
    # @param api_key [String]
    # @return [RequestClient]
    def initialize(api_key:, environment: Environment::DEFAULT, max_retries: nil, timeout_in_seconds: nil)
      @default_environment = environment
      @base_url = environment
      @headers = {
        "X-Fern-Language": "Ruby",
        "X-Fern-SDK-Name": "assemblyai",
        "X-Fern-SDK-Version": "1.0.0-beta.7",
        "Authorization": api_key.to_s
      }
      @conn = Faraday.new(@base_url, headers: @headers) do |faraday|
        faraday.request :json
        faraday.response :raise_error, include_request: true
        faraday.request :retry, { max: max_retries } unless max_retries.nil?
        faraday.options.timeout = timeout_in_seconds unless timeout_in_seconds.nil?
      end
    end
  end

  class AsyncRequestClient
    attr_reader :headers, :base_url, :conn

    # @param environment [Environment]
    # @param max_retries [Long] The number of times to retry a failed request, defaults to 2.
    # @param timeout_in_seconds [Long]
    # @param api_key [String]
    # @return [AsyncRequestClient]
    def initialize(api_key:, environment: Environment::DEFAULT, max_retries: nil, timeout_in_seconds: nil)
      @default_environment = environment
      @base_url = environment
      @headers = {
        "X-Fern-Language": "Ruby",
        "X-Fern-SDK-Name": "assemblyai",
        "X-Fern-SDK-Version": "1.0.0-beta.7",
        "Authorization": api_key.to_s
      }
      @conn = Faraday.new(@base_url, headers: @headers) do |faraday|
        faraday.request :json
        faraday.response :raise_error, include_request: true
        faraday.adapter :async_http
        faraday.request :retry, { max: max_retries } unless max_retries.nil?
        faraday.options.timeout = timeout_in_seconds unless timeout_in_seconds.nil?
      end
    end
  end

  # Additional options for request-specific configuration when calling APIs via the SDK.
  class RequestOptions
    attr_reader :api_key, :additional_headers, :additional_query_parameters, :additional_body_parameters,
                :timeout_in_seconds

    # @param api_key [String]
    # @param additional_headers [Hash{String => Object}]
    # @param additional_query_parameters [Hash{String => Object}]
    # @param additional_body_parameters [Hash{String => Object}]
    # @param timeout_in_seconds [Long]
    # @return [RequestOptions]
    def initialize(api_key: nil, additional_headers: nil, additional_query_parameters: nil,
                   additional_body_parameters: nil, timeout_in_seconds: nil)
      # @type [String]
      @api_key = api_key
      # @type [Hash{String => Object}]
      @additional_headers = additional_headers
      # @type [Hash{String => Object}]
      @additional_query_parameters = additional_query_parameters
      # @type [Hash{String => Object}]
      @additional_body_parameters = additional_body_parameters
      # @type [Long]
      @timeout_in_seconds = timeout_in_seconds
    end
  end

  # Additional options for request-specific configuration when calling APIs via the SDK.
  class IdempotencyRequestOptions
    attr_reader :api_key, :additional_headers, :additional_query_parameters, :additional_body_parameters,
                :timeout_in_seconds

    # @param api_key [String]
    # @param additional_headers [Hash{String => Object}]
    # @param additional_query_parameters [Hash{String => Object}]
    # @param additional_body_parameters [Hash{String => Object}]
    # @param timeout_in_seconds [Long]
    # @return [IdempotencyRequestOptions]
    def initialize(api_key: nil, additional_headers: nil, additional_query_parameters: nil,
                   additional_body_parameters: nil, timeout_in_seconds: nil)
      # @type [String]
      @api_key = api_key
      # @type [Hash{String => Object}]
      @additional_headers = additional_headers
      # @type [Hash{String => Object}]
      @additional_query_parameters = additional_query_parameters
      # @type [Hash{String => Object}]
      @additional_body_parameters = additional_body_parameters
      # @type [Long]
      @timeout_in_seconds = timeout_in_seconds
    end
  end
end
