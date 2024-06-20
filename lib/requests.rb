# frozen_string_literal: true

require_relative "environment"
require_relative "user_agent"
require "faraday"
require "faraday/retry"
require "async/http/faraday"

module AssemblyAI
  class RequestClient
    # @return [Hash{String => String}]
    attr_reader :headers
    # @return [Faraday]
    attr_reader :conn
    # @return [String]
    attr_reader :base_url
    # @return [String]
    attr_reader :default_environment

    # @param api_key [String]
    # @param environment [AssemblyAI::Environment]
    # @param base_url [String]
    # @param max_retries [Long] The number of times to retry a failed request, defaults to 2.
    # @param timeout_in_seconds [Long]
    # @param user_agent [AssemblyAI::UserAgent]
    # @return [AssemblyAI::RequestClient]
    def initialize(api_key:, environment: AssemblyAI::Environment::DEFAULT, base_url: nil, max_retries: nil,
                   timeout_in_seconds: nil, user_agent: nil)
      @default_environment = environment
      @base_url = environment || base_url
      @headers = {
        "X-Fern-Language": "Ruby",
        "X-Fern-SDK-Name": "assemblyai",
        "X-Fern-SDK-Version": "1.0.0",
        "Authorization": api_key.to_s,
        "User-Agent": AssemblyAI::UserAgent.merge(AssemblyAI::DefaultUserAgent.instance.user_agent, user_agent).serialize
      }
      @conn = Faraday.new(headers: @headers) do |faraday|
        faraday.request :json
        faraday.response :raise_error, include_request: true
        faraday.request :retry, { max: max_retries } unless max_retries.nil?
        faraday.options.timeout = timeout_in_seconds unless timeout_in_seconds.nil?
      end
    end

    # @param request_options [AssemblyAI::RequestOptions]
    # @return [String]
    def get_url(request_options: nil)
      request_options&.base_url || @default_environment || @base_url
    end
  end

  class AsyncRequestClient
    # @return [Hash{String => String}]
    attr_reader :headers
    # @return [Faraday]
    attr_reader :conn
    # @return [String]
    attr_reader :base_url
    # @return [String]
    attr_reader :default_environment

    # @param environment [AssemblyAI::Environment]
    # @param base_url [String]
    # @param max_retries [Long] The number of times to retry a failed request, defaults to 2.
    # @param timeout_in_seconds [Long]
    # @param api_key [String]
    # @param user_agent [AssemblyAI::UserAgent]
    # @return [AssemblyAI::AsyncRequestClient]
    def initialize(api_key:, environment: AssemblyAI::Environment::DEFAULT, base_url: nil, max_retries: nil,
                   timeout_in_seconds: nil, user_agent: nil)
      @default_environment = environment
      @base_url = environment || base_url
      @headers = {
        "X-Fern-Language": "Ruby",
        "X-Fern-SDK-Name": "assemblyai",
        "X-Fern-SDK-Version": "1.0.0",
        "Authorization": api_key.to_s,
        "User-Agent": AssemblyAI::UserAgent.merge(AssemblyAI::DefaultUserAgent.instance.user_agent, user_agent).serialize
      }
      @conn = Faraday.new(headers: @headers) do |faraday|
        faraday.request :json
        faraday.response :raise_error, include_request: true
        faraday.adapter :async_http
        faraday.request :retry, { max: max_retries } unless max_retries.nil?
        faraday.options.timeout = timeout_in_seconds unless timeout_in_seconds.nil?
      end
    end

    # @param request_options [AssemblyAI::RequestOptions]
    # @return [String]
    def get_url(request_options: nil)
      request_options&.base_url || @default_environment || @base_url
    end
  end

  # Additional options for request-specific configuration when calling APIs via the
  #  SDK.
  class RequestOptions
    # @return [String]
    attr_reader :base_url
    # @return [String]
    attr_reader :api_key
    # @return [Hash{String => Object}]
    attr_reader :additional_headers
    # @return [Hash{String => Object}]
    attr_reader :additional_query_parameters
    # @return [Hash{String => Object}]
    attr_reader :additional_body_parameters
    # @return [Long]
    attr_reader :timeout_in_seconds

    # @param base_url [String]
    # @param api_key [String]
    # @param additional_headers [Hash{String => Object}]
    # @param additional_query_parameters [Hash{String => Object}]
    # @param additional_body_parameters [Hash{String => Object}]
    # @param timeout_in_seconds [Long]
    # @return [AssemblyAI::RequestOptions]
    def initialize(base_url: nil, api_key: nil, additional_headers: nil, additional_query_parameters: nil,
                   additional_body_parameters: nil, timeout_in_seconds: nil)
      @base_url = base_url
      @api_key = api_key
      @additional_headers = additional_headers
      @additional_query_parameters = additional_query_parameters
      @additional_body_parameters = additional_body_parameters
      @timeout_in_seconds = timeout_in_seconds
    end
  end

  # Additional options for request-specific configuration when calling APIs via the
  #  SDK.
  class IdempotencyRequestOptions
    # @return [String]
    attr_reader :base_url
    # @return [String]
    attr_reader :api_key
    # @return [Hash{String => Object}]
    attr_reader :additional_headers
    # @return [Hash{String => Object}]
    attr_reader :additional_query_parameters
    # @return [Hash{String => Object}]
    attr_reader :additional_body_parameters
    # @return [Long]
    attr_reader :timeout_in_seconds

    # @param base_url [String]
    # @param api_key [String]
    # @param additional_headers [Hash{String => Object}]
    # @param additional_query_parameters [Hash{String => Object}]
    # @param additional_body_parameters [Hash{String => Object}]
    # @param timeout_in_seconds [Long]
    # @return [AssemblyAI::IdempotencyRequestOptions]
    def initialize(base_url: nil, api_key: nil, additional_headers: nil, additional_query_parameters: nil,
                   additional_body_parameters: nil, timeout_in_seconds: nil)
      @base_url = base_url
      @api_key = api_key
      @additional_headers = additional_headers
      @additional_query_parameters = additional_query_parameters
      @additional_body_parameters = additional_body_parameters
      @timeout_in_seconds = timeout_in_seconds
    end
  end
end
