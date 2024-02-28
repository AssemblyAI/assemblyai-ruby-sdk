# frozen_string_literal: true

require_relative "../../requests"
require_relative "types/transcript_list"
require "async"

module AssemblyAI

  # :nodoc:
  class TranscriptsClient
    # Retrieve a list of transcripts you created
    #
    # @param url [String] The URL to retrieve the transcript list from
    # @param request_options [RequestOptions]
    # @return [Transcripts::TranscriptList]
    def list_by_url(url: nil, request_options: nil)
      if url.nil?
        url = "/v2/transcript"
      end
      response = @request_client.conn.get(url) do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
      end
      Transcripts::TranscriptList.from_json(json_object: response.body)
    end
  end

  # :nodoc:
  class AsyncTranscriptsClient

    # Retrieve a list of transcripts you created
    #
    # @param url [String] The URL to retrieve the transcript list from
    # @param request_options [RequestOptions]
    # @return [Transcripts::TranscriptList]
    def list_by_url(url: nil, request_options: nil)
      Async do
        if url.nil?
          url = "/v2/transcript"
        end
        response = @request_client.conn.get(url) do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
        end
        Transcripts::TranscriptList.from_json(json_object: response.body)
      end
    end
  end
end
