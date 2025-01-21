# frozen_string_literal: true

require_relative "../../requests"
require_relative "types/transcript_status"
require_relative "types/transcript_list"
require_relative "types/transcript_language_code"
require_relative "types/speech_model"
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
require "async"

module AssemblyAI
  class TranscriptsClient
    # @return [AssemblyAI::RequestClient]
    attr_reader :request_client

    # @param request_client [AssemblyAI::RequestClient]
    # @return [AssemblyAI::TranscriptsClient]
    def initialize(request_client:)
      @request_client = request_client
    end

    # Retrieve a list of transcripts you created.
    #  Transcripts are sorted from newest to oldest. The previous URL always points to
    #  a page with older transcripts.
    #
    # @param limit [Integer] Maximum amount of transcripts to retrieve
    # @param status [AssemblyAI::Transcripts::TranscriptStatus] Filter by transcript status
    # @param created_on [String] Only get transcripts created on this date
    # @param before_id [String] Get transcripts that were created before this transcript ID
    # @param after_id [String] Get transcripts that were created after this transcript ID
    # @param throttled_only [Boolean] Only get throttled transcripts, overrides the status filter
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::TranscriptList]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.list
    def list(limit: nil, status: nil, created_on: nil, before_id: nil, after_id: nil, throttled_only: nil,
             request_options: nil)
      response = @request_client.conn.get do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = {
      **(req.headers || {}),
      **@request_client.get_headers,
      **(request_options&.additional_headers || {})
        }.compact
        req.params = {
          **(request_options&.additional_query_parameters || {}),
          "limit": limit,
          "status": status,
          "created_on": created_on,
          "before_id": before_id,
          "after_id": after_id,
          "throttled_only": throttled_only
        }.compact
        unless request_options.nil? || request_options&.additional_body_parameters.nil?
          req.body = { **(request_options&.additional_body_parameters || {}) }.compact
        end
        req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript"
      end
      AssemblyAI::Transcripts::TranscriptList.from_json(json_object: response.body)
    end

    # Create a transcript from a media file that is accessible via a URL.
    #
    # @param language_code [AssemblyAI::Transcripts::TranscriptLanguageCode]
    # @param language_detection [Boolean] Enable [Automatic language
    #  www.assemblyai.com/docs/models/speech-recognition#automatic-language-detection),
    #  either true or false.
    # @param language_confidence_threshold [Float] The confidence threshold for the automatically detected language.
    #  An error will be returned if the language confidence is below this threshold.
    #  Defaults to 0.
    # @param speech_model [AssemblyAI::Transcripts::SpeechModel]
    # @param punctuate [Boolean] Enable Automatic Punctuation, can be true or false
    # @param format_text [Boolean] Enable Text Formatting, can be true or false
    # @param disfluencies [Boolean] Transcribe Filler Words, like "umm", in your media file; can be true or false
    # @param multichannel [Boolean] Enable
    #  ://www.assemblyai.com/docs/models/speech-recognition#multichannel-transcription)
    #  transcription, can be true or false.
    # @param dual_channel [Boolean] Enable [Dual
    #  ://www.assemblyai.com/docs/models/speech-recognition#dual-channel-transcription)
    #  transcription, can be true or false.
    # @param webhook_url [String] The URL to which we send webhook requests.
    #  We sends two different types of webhook requests.
    #  One request when a transcript is completed or failed, and one request when the
    #  redacted audio is ready if redact_pii_audio is enabled.
    # @param webhook_auth_header_name [String] The header name to be sent with the transcript completed or failed webhook
    #  requests
    # @param webhook_auth_header_value [String] The header value to send back with the transcript completed or failed webhook
    #  requests for added security
    # @param auto_highlights [Boolean] Enable Key Phrases, either true or false
    # @param audio_start_from [Integer] The point in time, in milliseconds, to begin transcribing in your media file
    # @param audio_end_at [Integer] The point in time, in milliseconds, to stop transcribing in your media file
    # @param word_boost [Array<String>] The list of custom vocabulary to boost transcription probability for
    # @param boost_param [AssemblyAI::Transcripts::TranscriptBoostParam] How much to boost specified words
    # @param filter_profanity [Boolean] Filter profanity from the transcribed text, can be true or false
    # @param redact_pii [Boolean] Redact PII from the transcribed text using the Redact PII model, can be true or
    #  false
    # @param redact_pii_audio [Boolean] Generate a copy of the original media file with spoken PII "beeped" out, can be
    #  true or false. See [PII
    #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
    #  details.
    # @param redact_pii_audio_quality [AssemblyAI::Transcripts::RedactPiiAudioQuality] Controls the filetype of the audio created by redact_pii_audio. Currently
    #  supports mp3 (default) and wav. See [PII
    #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
    #  details.
    # @param redact_pii_policies [Array<AssemblyAI::Transcripts::PiiPolicy>] The list of PII Redaction policies to enable. See [PII
    #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
    #  details.
    # @param redact_pii_sub [AssemblyAI::Transcripts::SubstitutionPolicy]
    # @param speaker_labels [Boolean] Enable [Speaker
    #  diarization](https://www.assemblyai.com/docs/models/speaker-diarization), can be
    #  true or false
    # @param speakers_expected [Integer] Tells the speaker label model how many speakers it should attempt to identify,
    #  up to 10. See [Speaker
    #  diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for
    #  more details.
    # @param content_safety [Boolean] Enable [Content
    #  Moderation](https://www.assemblyai.com/docs/models/content-moderation), can be
    #  true or false
    # @param content_safety_confidence [Integer] The confidence threshold for the Content Moderation model. Values must be
    #  between 25 and 100.
    # @param iab_categories [Boolean] Enable [Topic
    #  Detection](https://www.assemblyai.com/docs/models/topic-detection), can be true
    #  or false
    # @param custom_spelling [Array<Hash>] Customize how words are spelled and formatted using to and from valuesRequest of type Array<AssemblyAI::Transcripts::TranscriptCustomSpelling>, as a Hash
    #   * :from (Array<String>)
    #   * :to (String)
    # @param sentiment_analysis [Boolean] Enable [Sentiment
    #  Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis), can be
    #  true or false
    # @param auto_chapters [Boolean] Enable [Auto Chapters](https://www.assemblyai.com/docs/models/auto-chapters),
    #  can be true or false
    # @param entity_detection [Boolean] Enable [Entity
    #  Detection](https://www.assemblyai.com/docs/models/entity-detection), can be true
    #  or false
    # @param speech_threshold [Float] Reject audio files that contain less than this fraction of speech.
    #  Valid values are in the range [0, 1] inclusive.
    # @param summarization [Boolean] Enable [Summarization](https://www.assemblyai.com/docs/models/summarization),
    #  can be true or false
    # @param summary_model [AssemblyAI::Transcripts::SummaryModel] The model to summarize the transcript
    # @param summary_type [AssemblyAI::Transcripts::SummaryType] The type of summary
    # @param custom_topics [Boolean] Enable custom topics, either true or false
    # @param topics [Array<String>] The list of custom topics
    # @param audio_url [String] The URL of the audio or video file to transcribe.
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::Transcript]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.submit(audio_url: "https://assembly.ai/wildfires.mp3")
    def submit(audio_url:, language_code: nil, language_detection: nil, language_confidence_threshold: nil, speech_model: nil,
               punctuate: nil, format_text: nil, disfluencies: nil, multichannel: nil, dual_channel: nil, webhook_url: nil, webhook_auth_header_name: nil, webhook_auth_header_value: nil, auto_highlights: nil, audio_start_from: nil, audio_end_at: nil, word_boost: nil, boost_param: nil, filter_profanity: nil, redact_pii: nil, redact_pii_audio: nil, redact_pii_audio_quality: nil, redact_pii_policies: nil, redact_pii_sub: nil, speaker_labels: nil, speakers_expected: nil, content_safety: nil, content_safety_confidence: nil, iab_categories: nil, custom_spelling: nil, sentiment_analysis: nil, auto_chapters: nil, entity_detection: nil, speech_threshold: nil, summarization: nil, summary_model: nil, summary_type: nil, custom_topics: nil, topics: nil, request_options: nil)
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
        req.body = {
          **(request_options&.additional_body_parameters || {}),
          language_code: language_code,
          language_detection: language_detection,
          language_confidence_threshold: language_confidence_threshold,
          speech_model: speech_model,
          punctuate: punctuate,
          format_text: format_text,
          disfluencies: disfluencies,
          multichannel: multichannel,
          dual_channel: dual_channel,
          webhook_url: webhook_url,
          webhook_auth_header_name: webhook_auth_header_name,
          webhook_auth_header_value: webhook_auth_header_value,
          auto_highlights: auto_highlights,
          audio_start_from: audio_start_from,
          audio_end_at: audio_end_at,
          word_boost: word_boost,
          boost_param: boost_param,
          filter_profanity: filter_profanity,
          redact_pii: redact_pii,
          redact_pii_audio: redact_pii_audio,
          redact_pii_audio_quality: redact_pii_audio_quality,
          redact_pii_policies: redact_pii_policies,
          redact_pii_sub: redact_pii_sub,
          speaker_labels: speaker_labels,
          speakers_expected: speakers_expected,
          content_safety: content_safety,
          content_safety_confidence: content_safety_confidence,
          iab_categories: iab_categories,
          custom_spelling: custom_spelling,
          sentiment_analysis: sentiment_analysis,
          auto_chapters: auto_chapters,
          entity_detection: entity_detection,
          speech_threshold: speech_threshold,
          summarization: summarization,
          summary_model: summary_model,
          summary_type: summary_type,
          custom_topics: custom_topics,
          topics: topics,
          audio_url: audio_url
        }.compact
        req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript"
      end
      AssemblyAI::Transcripts::Transcript.from_json(json_object: response.body)
    end

    # Get the transcript resource. The transcript is ready when the "status" is
    #  "completed".
    #
    # @param transcript_id [String] ID of the transcript
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::Transcript]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.get(transcript_id: "transcript_id")
    def get(transcript_id:, request_options: nil)
      response = @request_client.conn.get do |req|
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
        unless request_options.nil? || request_options&.additional_body_parameters.nil?
          req.body = { **(request_options&.additional_body_parameters || {}) }.compact
        end
        req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}"
      end
      AssemblyAI::Transcripts::Transcript.from_json(json_object: response.body)
    end

    # Remove the data from the transcript and mark it as deleted.
    #
    # @param transcript_id [String] ID of the transcript
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::Transcript]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.delete(transcript_id: "{transcript_id}")
    def delete(transcript_id:, request_options: nil)
      response = @request_client.conn.delete do |req|
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
        unless request_options.nil? || request_options&.additional_body_parameters.nil?
          req.body = { **(request_options&.additional_body_parameters || {}) }.compact
        end
        req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}"
      end
      AssemblyAI::Transcripts::Transcript.from_json(json_object: response.body)
    end

    # Export your transcript in SRT or VTT format to use with a video player for
    #  subtitles and closed captions.
    #
    # @param transcript_id [String] ID of the transcript
    # @param subtitle_format [AssemblyAI::Transcripts::SubtitleFormat] The format of the captions
    # @param chars_per_caption [Integer] The maximum number of characters per caption
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [String]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.get_subtitles(
    #    transcript_id: "string",
    #    subtitle_format: SRT,
    #    chars_per_caption: 1
    #  )
    def get_subtitles(transcript_id:, subtitle_format:, chars_per_caption: nil, request_options: nil)
      response = @request_client.conn.get do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = {
      **(req.headers || {}),
      **@request_client.get_headers,
      **(request_options&.additional_headers || {})
        }.compact
        req.params = {
          **(request_options&.additional_query_parameters || {}),
          "chars_per_caption": chars_per_caption
        }.compact
        unless request_options.nil? || request_options&.additional_body_parameters.nil?
          req.body = { **(request_options&.additional_body_parameters || {}) }.compact
        end
        req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}/#{subtitle_format}"
      end
      response.body
    end

    # Get the transcript split by sentences. The API will attempt to semantically
    #  segment the transcript into sentences to create more reader-friendly
    #  transcripts.
    #
    # @param transcript_id [String] ID of the transcript
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::SentencesResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.get_sentences(transcript_id: "transcript_id")
    def get_sentences(transcript_id:, request_options: nil)
      response = @request_client.conn.get do |req|
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
        unless request_options.nil? || request_options&.additional_body_parameters.nil?
          req.body = { **(request_options&.additional_body_parameters || {}) }.compact
        end
        req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}/sentences"
      end
      AssemblyAI::Transcripts::SentencesResponse.from_json(json_object: response.body)
    end

    # Get the transcript split by paragraphs. The API will attempt to semantically
    #  segment your transcript into paragraphs to create more reader-friendly
    #  transcripts.
    #
    # @param transcript_id [String] ID of the transcript
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::ParagraphsResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.get_paragraphs(transcript_id: "transcript_id")
    def get_paragraphs(transcript_id:, request_options: nil)
      response = @request_client.conn.get do |req|
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
        unless request_options.nil? || request_options&.additional_body_parameters.nil?
          req.body = { **(request_options&.additional_body_parameters || {}) }.compact
        end
        req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}/paragraphs"
      end
      AssemblyAI::Transcripts::ParagraphsResponse.from_json(json_object: response.body)
    end

    # Search through the transcript for keywords. You can search for individual words,
    #  numbers, or phrases containing up to five words or numbers.
    #
    # @param transcript_id [String] ID of the transcript
    # @param words [String] Keywords to search for
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::WordSearchResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.word_search(transcript_id: "string", words: "string")
    def word_search(transcript_id:, words: nil, request_options: nil)
      response = @request_client.conn.get do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = {
      **(req.headers || {}),
      **@request_client.get_headers,
      **(request_options&.additional_headers || {})
        }.compact
        req.params = { **(request_options&.additional_query_parameters || {}), "words": words }.compact
        unless request_options.nil? || request_options&.additional_body_parameters.nil?
          req.body = { **(request_options&.additional_body_parameters || {}) }.compact
        end
        req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}/word-search"
      end
      AssemblyAI::Transcripts::WordSearchResponse.from_json(json_object: response.body)
    end

    # Retrieve the redacted audio object containing the status and URL to the redacted
    #  audio.
    #
    # @param transcript_id [String] ID of the transcript
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::RedactedAudioResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.get_redacted_audio(transcript_id: "transcript_id")
    def get_redacted_audio(transcript_id:, request_options: nil)
      response = @request_client.conn.get do |req|
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
        unless request_options.nil? || request_options&.additional_body_parameters.nil?
          req.body = { **(request_options&.additional_body_parameters || {}) }.compact
        end
        req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}/redacted-audio"
      end
      AssemblyAI::Transcripts::RedactedAudioResponse.from_json(json_object: response.body)
    end
  end

  class AsyncTranscriptsClient
    # @return [AssemblyAI::AsyncRequestClient]
    attr_reader :request_client

    # @param request_client [AssemblyAI::AsyncRequestClient]
    # @return [AssemblyAI::AsyncTranscriptsClient]
    def initialize(request_client:)
      @request_client = request_client
    end

    # Retrieve a list of transcripts you created.
    #  Transcripts are sorted from newest to oldest. The previous URL always points to
    #  a page with older transcripts.
    #
    # @param limit [Integer] Maximum amount of transcripts to retrieve
    # @param status [AssemblyAI::Transcripts::TranscriptStatus] Filter by transcript status
    # @param created_on [String] Only get transcripts created on this date
    # @param before_id [String] Get transcripts that were created before this transcript ID
    # @param after_id [String] Get transcripts that were created after this transcript ID
    # @param throttled_only [Boolean] Only get throttled transcripts, overrides the status filter
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::TranscriptList]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.list
    def list(limit: nil, status: nil, created_on: nil, before_id: nil, after_id: nil, throttled_only: nil,
             request_options: nil)
      Async do
        response = @request_client.conn.get do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = {
        **(req.headers || {}),
        **@request_client.get_headers,
        **(request_options&.additional_headers || {})
          }.compact
          req.params = {
            **(request_options&.additional_query_parameters || {}),
            "limit": limit,
            "status": status,
            "created_on": created_on,
            "before_id": before_id,
            "after_id": after_id,
            "throttled_only": throttled_only
          }.compact
          unless request_options.nil? || request_options&.additional_body_parameters.nil?
            req.body = { **(request_options&.additional_body_parameters || {}) }.compact
          end
          req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript"
        end
        AssemblyAI::Transcripts::TranscriptList.from_json(json_object: response.body)
      end
    end

    # Create a transcript from a media file that is accessible via a URL.
    #
    # @param language_code [AssemblyAI::Transcripts::TranscriptLanguageCode]
    # @param language_detection [Boolean] Enable [Automatic language
    #  www.assemblyai.com/docs/models/speech-recognition#automatic-language-detection),
    #  either true or false.
    # @param language_confidence_threshold [Float] The confidence threshold for the automatically detected language.
    #  An error will be returned if the language confidence is below this threshold.
    #  Defaults to 0.
    # @param speech_model [AssemblyAI::Transcripts::SpeechModel]
    # @param punctuate [Boolean] Enable Automatic Punctuation, can be true or false
    # @param format_text [Boolean] Enable Text Formatting, can be true or false
    # @param disfluencies [Boolean] Transcribe Filler Words, like "umm", in your media file; can be true or false
    # @param multichannel [Boolean] Enable
    #  ://www.assemblyai.com/docs/models/speech-recognition#multichannel-transcription)
    #  transcription, can be true or false.
    # @param dual_channel [Boolean] Enable [Dual
    #  ://www.assemblyai.com/docs/models/speech-recognition#dual-channel-transcription)
    #  transcription, can be true or false.
    # @param webhook_url [String] The URL to which we send webhook requests.
    #  We sends two different types of webhook requests.
    #  One request when a transcript is completed or failed, and one request when the
    #  redacted audio is ready if redact_pii_audio is enabled.
    # @param webhook_auth_header_name [String] The header name to be sent with the transcript completed or failed webhook
    #  requests
    # @param webhook_auth_header_value [String] The header value to send back with the transcript completed or failed webhook
    #  requests for added security
    # @param auto_highlights [Boolean] Enable Key Phrases, either true or false
    # @param audio_start_from [Integer] The point in time, in milliseconds, to begin transcribing in your media file
    # @param audio_end_at [Integer] The point in time, in milliseconds, to stop transcribing in your media file
    # @param word_boost [Array<String>] The list of custom vocabulary to boost transcription probability for
    # @param boost_param [AssemblyAI::Transcripts::TranscriptBoostParam] How much to boost specified words
    # @param filter_profanity [Boolean] Filter profanity from the transcribed text, can be true or false
    # @param redact_pii [Boolean] Redact PII from the transcribed text using the Redact PII model, can be true or
    #  false
    # @param redact_pii_audio [Boolean] Generate a copy of the original media file with spoken PII "beeped" out, can be
    #  true or false. See [PII
    #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
    #  details.
    # @param redact_pii_audio_quality [AssemblyAI::Transcripts::RedactPiiAudioQuality] Controls the filetype of the audio created by redact_pii_audio. Currently
    #  supports mp3 (default) and wav. See [PII
    #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
    #  details.
    # @param redact_pii_policies [Array<AssemblyAI::Transcripts::PiiPolicy>] The list of PII Redaction policies to enable. See [PII
    #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
    #  details.
    # @param redact_pii_sub [AssemblyAI::Transcripts::SubstitutionPolicy]
    # @param speaker_labels [Boolean] Enable [Speaker
    #  diarization](https://www.assemblyai.com/docs/models/speaker-diarization), can be
    #  true or false
    # @param speakers_expected [Integer] Tells the speaker label model how many speakers it should attempt to identify,
    #  up to 10. See [Speaker
    #  diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for
    #  more details.
    # @param content_safety [Boolean] Enable [Content
    #  Moderation](https://www.assemblyai.com/docs/models/content-moderation), can be
    #  true or false
    # @param content_safety_confidence [Integer] The confidence threshold for the Content Moderation model. Values must be
    #  between 25 and 100.
    # @param iab_categories [Boolean] Enable [Topic
    #  Detection](https://www.assemblyai.com/docs/models/topic-detection), can be true
    #  or false
    # @param custom_spelling [Array<Hash>] Customize how words are spelled and formatted using to and from valuesRequest of type Array<AssemblyAI::Transcripts::TranscriptCustomSpelling>, as a Hash
    #   * :from (Array<String>)
    #   * :to (String)
    # @param sentiment_analysis [Boolean] Enable [Sentiment
    #  Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis), can be
    #  true or false
    # @param auto_chapters [Boolean] Enable [Auto Chapters](https://www.assemblyai.com/docs/models/auto-chapters),
    #  can be true or false
    # @param entity_detection [Boolean] Enable [Entity
    #  Detection](https://www.assemblyai.com/docs/models/entity-detection), can be true
    #  or false
    # @param speech_threshold [Float] Reject audio files that contain less than this fraction of speech.
    #  Valid values are in the range [0, 1] inclusive.
    # @param summarization [Boolean] Enable [Summarization](https://www.assemblyai.com/docs/models/summarization),
    #  can be true or false
    # @param summary_model [AssemblyAI::Transcripts::SummaryModel] The model to summarize the transcript
    # @param summary_type [AssemblyAI::Transcripts::SummaryType] The type of summary
    # @param custom_topics [Boolean] Enable custom topics, either true or false
    # @param topics [Array<String>] The list of custom topics
    # @param audio_url [String] The URL of the audio or video file to transcribe.
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::Transcript]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.submit(audio_url: "https://assembly.ai/wildfires.mp3")
    def submit(audio_url:, language_code: nil, language_detection: nil, language_confidence_threshold: nil, speech_model: nil,
               punctuate: nil, format_text: nil, disfluencies: nil, multichannel: nil, dual_channel: nil, webhook_url: nil, webhook_auth_header_name: nil, webhook_auth_header_value: nil, auto_highlights: nil, audio_start_from: nil, audio_end_at: nil, word_boost: nil, boost_param: nil, filter_profanity: nil, redact_pii: nil, redact_pii_audio: nil, redact_pii_audio_quality: nil, redact_pii_policies: nil, redact_pii_sub: nil, speaker_labels: nil, speakers_expected: nil, content_safety: nil, content_safety_confidence: nil, iab_categories: nil, custom_spelling: nil, sentiment_analysis: nil, auto_chapters: nil, entity_detection: nil, speech_threshold: nil, summarization: nil, summary_model: nil, summary_type: nil, custom_topics: nil, topics: nil, request_options: nil)
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
          req.body = {
            **(request_options&.additional_body_parameters || {}),
            language_code: language_code,
            language_detection: language_detection,
            language_confidence_threshold: language_confidence_threshold,
            speech_model: speech_model,
            punctuate: punctuate,
            format_text: format_text,
            disfluencies: disfluencies,
            multichannel: multichannel,
            dual_channel: dual_channel,
            webhook_url: webhook_url,
            webhook_auth_header_name: webhook_auth_header_name,
            webhook_auth_header_value: webhook_auth_header_value,
            auto_highlights: auto_highlights,
            audio_start_from: audio_start_from,
            audio_end_at: audio_end_at,
            word_boost: word_boost,
            boost_param: boost_param,
            filter_profanity: filter_profanity,
            redact_pii: redact_pii,
            redact_pii_audio: redact_pii_audio,
            redact_pii_audio_quality: redact_pii_audio_quality,
            redact_pii_policies: redact_pii_policies,
            redact_pii_sub: redact_pii_sub,
            speaker_labels: speaker_labels,
            speakers_expected: speakers_expected,
            content_safety: content_safety,
            content_safety_confidence: content_safety_confidence,
            iab_categories: iab_categories,
            custom_spelling: custom_spelling,
            sentiment_analysis: sentiment_analysis,
            auto_chapters: auto_chapters,
            entity_detection: entity_detection,
            speech_threshold: speech_threshold,
            summarization: summarization,
            summary_model: summary_model,
            summary_type: summary_type,
            custom_topics: custom_topics,
            topics: topics,
            audio_url: audio_url
          }.compact
          req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript"
        end
        AssemblyAI::Transcripts::Transcript.from_json(json_object: response.body)
      end
    end

    # Get the transcript resource. The transcript is ready when the "status" is
    #  "completed".
    #
    # @param transcript_id [String] ID of the transcript
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::Transcript]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.get(transcript_id: "transcript_id")
    def get(transcript_id:, request_options: nil)
      Async do
        response = @request_client.conn.get do |req|
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
          unless request_options.nil? || request_options&.additional_body_parameters.nil?
            req.body = { **(request_options&.additional_body_parameters || {}) }.compact
          end
          req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}"
        end
        AssemblyAI::Transcripts::Transcript.from_json(json_object: response.body)
      end
    end

    # Remove the data from the transcript and mark it as deleted.
    #
    # @param transcript_id [String] ID of the transcript
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::Transcript]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.delete(transcript_id: "{transcript_id}")
    def delete(transcript_id:, request_options: nil)
      Async do
        response = @request_client.conn.delete do |req|
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
          unless request_options.nil? || request_options&.additional_body_parameters.nil?
            req.body = { **(request_options&.additional_body_parameters || {}) }.compact
          end
          req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}"
        end
        AssemblyAI::Transcripts::Transcript.from_json(json_object: response.body)
      end
    end

    # Export your transcript in SRT or VTT format to use with a video player for
    #  subtitles and closed captions.
    #
    # @param transcript_id [String] ID of the transcript
    # @param subtitle_format [AssemblyAI::Transcripts::SubtitleFormat] The format of the captions
    # @param chars_per_caption [Integer] The maximum number of characters per caption
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [String]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.get_subtitles(
    #    transcript_id: "string",
    #    subtitle_format: SRT,
    #    chars_per_caption: 1
    #  )
    def get_subtitles(transcript_id:, subtitle_format:, chars_per_caption: nil, request_options: nil)
      Async do
        response = @request_client.conn.get do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = {
        **(req.headers || {}),
        **@request_client.get_headers,
        **(request_options&.additional_headers || {})
          }.compact
          req.params = {
            **(request_options&.additional_query_parameters || {}),
            "chars_per_caption": chars_per_caption
          }.compact
          unless request_options.nil? || request_options&.additional_body_parameters.nil?
            req.body = { **(request_options&.additional_body_parameters || {}) }.compact
          end
          req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}/#{subtitle_format}"
        end
        response.body
      end
    end

    # Get the transcript split by sentences. The API will attempt to semantically
    #  segment the transcript into sentences to create more reader-friendly
    #  transcripts.
    #
    # @param transcript_id [String] ID of the transcript
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::SentencesResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.get_sentences(transcript_id: "transcript_id")
    def get_sentences(transcript_id:, request_options: nil)
      Async do
        response = @request_client.conn.get do |req|
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
          unless request_options.nil? || request_options&.additional_body_parameters.nil?
            req.body = { **(request_options&.additional_body_parameters || {}) }.compact
          end
          req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}/sentences"
        end
        AssemblyAI::Transcripts::SentencesResponse.from_json(json_object: response.body)
      end
    end

    # Get the transcript split by paragraphs. The API will attempt to semantically
    #  segment your transcript into paragraphs to create more reader-friendly
    #  transcripts.
    #
    # @param transcript_id [String] ID of the transcript
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::ParagraphsResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.get_paragraphs(transcript_id: "transcript_id")
    def get_paragraphs(transcript_id:, request_options: nil)
      Async do
        response = @request_client.conn.get do |req|
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
          unless request_options.nil? || request_options&.additional_body_parameters.nil?
            req.body = { **(request_options&.additional_body_parameters || {}) }.compact
          end
          req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}/paragraphs"
        end
        AssemblyAI::Transcripts::ParagraphsResponse.from_json(json_object: response.body)
      end
    end

    # Search through the transcript for keywords. You can search for individual words,
    #  numbers, or phrases containing up to five words or numbers.
    #
    # @param transcript_id [String] ID of the transcript
    # @param words [String] Keywords to search for
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::WordSearchResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.word_search(transcript_id: "string", words: "string")
    def word_search(transcript_id:, words: nil, request_options: nil)
      Async do
        response = @request_client.conn.get do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = {
        **(req.headers || {}),
        **@request_client.get_headers,
        **(request_options&.additional_headers || {})
          }.compact
          req.params = { **(request_options&.additional_query_parameters || {}), "words": words }.compact
          unless request_options.nil? || request_options&.additional_body_parameters.nil?
            req.body = { **(request_options&.additional_body_parameters || {}) }.compact
          end
          req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}/word-search"
        end
        AssemblyAI::Transcripts::WordSearchResponse.from_json(json_object: response.body)
      end
    end

    # Retrieve the redacted audio object containing the status and URL to the redacted
    #  audio.
    #
    # @param transcript_id [String] ID of the transcript
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Transcripts::RedactedAudioResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.transcripts.get_redacted_audio(transcript_id: "transcript_id")
    def get_redacted_audio(transcript_id:, request_options: nil)
      Async do
        response = @request_client.conn.get do |req|
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
          unless request_options.nil? || request_options&.additional_body_parameters.nil?
            req.body = { **(request_options&.additional_body_parameters || {}) }.compact
          end
          req.url "#{@request_client.get_url(request_options: request_options)}/v2/transcript/#{transcript_id}/redacted-audio"
        end
        AssemblyAI::Transcripts::RedactedAudioResponse.from_json(json_object: response.body)
      end
    end
  end
end
