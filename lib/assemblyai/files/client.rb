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
    # @param file [String, IO] File path, Base64 String, or an IO object (e.g. Faraday::UploadIO, etc.)
    # @param request_options [RequestOptions]
    # @return [Files::UploadedFile]
    def upload(file:, request_options: nil)
      response = @request_client.conn.post("/v2/upload") do |req|
        if file.is_a? String
          begin
            path = Pathname.new(file)
          rescue StandardError
            file_data = file
          end
          unless path.nil?
            if path.file?
              file_data = File.new(file)
            elsif path.directory?
              raise "file path has to be a path to file, but is a path to directory"
            else
              raise "file at path does not exist"
            end
          end
        else
          file_data = file
        end
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
        req.headers["Content-Type"] = "application/octet-stream"
        if file.is_a? File
          req.headers["Content-Length"] = File.size(file_data.path).to_s
        else
          req.headers["Transfer-Encoding"] = "chunked"
        end
        req.body = file_data
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
    # @param file [String, IO] File path, Base64 String, or an IO object (e.g. Faraday::UploadIO, etc.)
    # @param request_options [RequestOptions]
    # @return [Files::UploadedFile]
    def upload(file:, request_options: nil)
      Async do
        response = @request_client.conn.post("/v2/upload") do |req|
          if file.is_a? String
            begin
              path = Pathname.new(file)
            rescue StandardError
              file_data = file
            end
            unless path.nil?
              if path.file?
                file_data = File.new(file)
              elsif path.directory?
                raise "file path has to be a path to file, but is a path to directory"
              else
                raise "file at path does not exist"
              end
            end
          else
            file_data = file
          end
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
          req.headers["Content-Type"] = "application/octet-stream"
          if file.is_a? File
            req.headers["Content-Length"] = File.size(file_data.path).to_s
          else
            req.headers["Transfer-Encoding"] = "chunked"
          end
          req.body = file_data
        end
        Files::UploadedFile.from_json(json_object: response.body)
      end
    end
  end
end
