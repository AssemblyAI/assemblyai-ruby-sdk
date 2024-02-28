# frozen_string_literal: true

require_relative "../../requests"
require_relative "types/transcript_status"
require_relative "types/transcript_list"
require_relative "types/transcript_language_code"
require_relative "types/transcript_boost_param"
require_relative "types/redact_pii_audio_quality"
require_relative "types/pii_policy"
require_relative "types/substitution_policy"
require_relative "types/transcript_custom_spelling"
require_relative "types/summary_model"
require_relative "types/summary_type"
require_relative "types/transcript"
require_relative "types/subtitle_format"
require_relative "types/sentences_response"
require_relative "types/paragraphs_response"
require_relative "types/word_search_response"
require_relative "types/redacted_audio_response"
require_relative "types/polling_options"
require "async"

module AssemblyAI
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
