# frozen_string_literal: true

require_relative "../../requests"
require_relative "types/uploaded_file"
require "async"

module AssemblyAI
  class FilesClient
    attr_reader :request_client

    # @param request_client [RequestClient]
    # @return [FilesClient]
    def initialize(request_client:)
      # @type [RequestClient]
      @request_client = request_client
    end

    # Upload your media file directly to the AssemblyAI API if it isn't accessible via a URL already.
    #
    # @param request [String, IO] Base64 encoded bytes, or an IO object (e.g. Faraday::UploadIO, etc.)
    # @param request_options [RequestOptions]
    # @return [Files::UploadedFile]
    def upload(request:, request_options: nil)
      response = @request_client.conn.post("/v2/upload") do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
        req.headers["Content-Type"] = "application/octet-stream"
        req.body = request
      end
      Files::UploadedFile.from_json(json_object: response.body)
    end
  end

  class AsyncFilesClient
    attr_reader :request_client

    # @param request_client [AsyncRequestClient]
    # @return [AsyncFilesClient]
    def initialize(request_client:)
      # @type [AsyncRequestClient]
      @request_client = request_client
    end

    # Upload your media file directly to the AssemblyAI API if it isn't accessible via a URL already.
    #
    # @param request [String, IO] Base64 encoded bytes, or an IO object (e.g. Faraday::UploadIO, etc.)
    # @param request_options [RequestOptions]
    # @return [Files::UploadedFile]
    def upload(request:, request_options: nil)
      Async do
        response = @request_client.conn.post("/v2/upload") do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
          req.headers["Content-Type"] = "application/octet-stream"
          req.body = request
        end
        Files::UploadedFile.from_json(json_object: response.body)
      end
    end
  end
end
