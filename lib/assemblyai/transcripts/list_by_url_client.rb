# frozen_string_literal: true

require_relative "../../requests"
require_relative "types/transcript_list"
require "async"

module AssemblyAI
  # :nodoc:
  class TranscriptsClient
    # Retrieve a list of transcripts you created, this is used for pagination to easily retrieve the next page of transcripts
    #
    # @param url [String] The URL to retrieve the transcript list from
    # @param request_options [RequestOptions]
    # @return [Transcripts::TranscriptList]
    #
    # @example Retrieve the next page of results
    #   client = AssemblyAI::Client.new(api_key: "YOUR_API_KEY")
    #   transcript_list = client.transcripts.list(limit: 1)
    #   client.transcripts.list_by_url(url: transcript_list.page_details.next_url)
    def list_by_url(url: nil, request_options: nil)
      url = "#{@request_client.get_url(request_options: request_options)}/v2/transcript" if url.nil?
      response = @request_client.conn.get do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
        req.url url
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
    #
    # @example Retrieve the next page of results
    #   client = AssemblyAI::AsyncClient.new(api_key: "YOUR_API_KEY")
    #   Sync do
    #     transcript_list = client.transcripts.list(limit: 1).wait
    #     client.transcripts.list_by_url(url: transcript_list.page_details.next_url)
    #   end
    def list_by_url(url: nil, request_options: nil)
      Async do
        url = "#{@request_client.get_url(request_options: request_options)}/v2/transcript" if url.nil?
        response = @request_client.conn.get do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
          req.url url
        end
        Transcripts::TranscriptList.from_json(json_object: response.body)
      end
    end
  end
end
