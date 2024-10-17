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
  # :nodoc:
  class TranscriptsClient
    # Create a transcript from an audio or video file that is accessible via a URL.
    # .transcribe polls for completion of the transcription, while the .submit function does not.
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
    # @param polling_options [Transcripts::PollingOptions] Configuration options for polling requests.
    # @return [Transcripts::Transcript]
    def transcribe(audio_url:, language_code: nil, language_detection: nil, language_confidence_threshold: nil, speech_model: nil,
                   punctuate: nil, format_text: nil, disfluencies: nil, multichannel: nil, dual_channel: nil, webhook_url: nil, webhook_auth_header_name: nil, webhook_auth_header_value: nil, auto_highlights: nil, audio_start_from: nil, audio_end_at: nil, word_boost: nil, boost_param: nil, filter_profanity: nil, redact_pii: nil, redact_pii_audio: nil, redact_pii_audio_quality: nil, redact_pii_policies: nil, redact_pii_sub: nil, speaker_labels: nil, speakers_expected: nil, content_safety: nil, content_safety_confidence: nil, iab_categories: nil, custom_spelling: nil, sentiment_analysis: nil, auto_chapters: nil, entity_detection: nil, speech_threshold: nil, summarization: nil, summary_model: nil, summary_type: nil, custom_topics: nil, topics: nil, request_options: nil, polling_options: Transcripts::PollingOptions.new)
      transcript = submit(audio_url: audio_url, speech_model: speech_model, language_code: language_code, punctuate: punctuate, format_text: format_text, dual_channel: dual_channel,
                          webhook_url: webhook_url, webhook_auth_header_name: webhook_auth_header_name, webhook_auth_header_value: webhook_auth_header_value, auto_highlights: auto_highlights, audio_start_from: audio_start_from, audio_end_at: audio_end_at, word_boost: word_boost, boost_param: boost_param, filter_profanity: filter_profanity, redact_pii: redact_pii, redact_pii_audio: redact_pii_audio, redact_pii_audio_quality: redact_pii_audio_quality, redact_pii_policies: redact_pii_policies, redact_pii_sub: redact_pii_sub, speaker_labels: speaker_labels, speakers_expected: speakers_expected, content_safety: content_safety, content_safety_confidence: content_safety_confidence, iab_categories: iab_categories, language_detection: language_detection, language_confidence_threshold: language_confidence_threshold, custom_spelling: custom_spelling, disfluencies: disfluencies, multichannel: multichannel, sentiment_analysis: sentiment_analysis, auto_chapters: auto_chapters, entity_detection: entity_detection, speech_threshold: speech_threshold, summarization: summarization, summary_model: summary_model, summary_type: summary_type, custom_topics: custom_topics, topics: topics, request_options: request_options)
      wait_until_ready(transcript_id: transcript.id, polling_options: polling_options)
    end

    # Wait until the transcript is ready. The transcript is ready when the "status" is "completed".
    #
    # @param transcript_id [String] ID of the transcript
    # @param polling_options [PollingOptions]
    # @return [Transcripts::Transcript]
    def wait_until_ready(transcript_id:, polling_options: Transcripts::PollingOptions.new)
      start_time = Time.now
      timeout_in_seconds = polling_options.timeout / 1000 if polling_options.timeout.positive?
      loop do
        transcript = get(transcript_id: transcript_id)
        if transcript.status == Transcripts::TranscriptStatus::COMPLETED || transcript.status == Transcripts::TranscriptStatus::ERROR
          return transcript
        elsif polling_options.timeout.positive? && Time.now - start_time > timeout_in_seconds
          raise StandardError, "Polling timeout"
        end

        sleep polling_options.interval / 1000
      end
    end
  end

  # :nodoc:
  class AsyncTranscriptsClient
    # Create a transcript from an audio or video file that is accessible via a URL.
    # .transcribe polls for completion of the transcription, while the .submit function does not.
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
    # @param polling_options [Transcripts::PollingOptions] Configuration options for polling requests.
    # @return [Transcripts::Transcript]
    def transcribe(audio_url:, language_code: nil, language_detection: nil, language_confidence_threshold: nil, speech_model: nil,
                   punctuate: nil, format_text: nil, disfluencies: nil, multichannel: nil, dual_channel: nil, webhook_url: nil, webhook_auth_header_name: nil, webhook_auth_header_value: nil, auto_highlights: nil, audio_start_from: nil, audio_end_at: nil, word_boost: nil, boost_param: nil, filter_profanity: nil, redact_pii: nil, redact_pii_audio: nil, redact_pii_audio_quality: nil, redact_pii_policies: nil, redact_pii_sub: nil, speaker_labels: nil, speakers_expected: nil, content_safety: nil, content_safety_confidence: nil, iab_categories: nil, custom_spelling: nil, sentiment_analysis: nil, auto_chapters: nil, entity_detection: nil, speech_threshold: nil, summarization: nil, summary_model: nil, summary_type: nil, custom_topics: nil, topics: nil, request_options: nil, polling_options: Transcripts::PollingOptions.new)
      Async do
        transcript = submit(audio_url: audio_url, speech_model: speech_model, language_code: language_code, punctuate: punctuate, format_text: format_text, dual_channel: dual_channel,
                            webhook_url: webhook_url, webhook_auth_header_name: webhook_auth_header_name, webhook_auth_header_value: webhook_auth_header_value, auto_highlights: auto_highlights, audio_start_from: audio_start_from, audio_end_at: audio_end_at, word_boost: word_boost, boost_param: boost_param, filter_profanity: filter_profanity, redact_pii: redact_pii, redact_pii_audio: redact_pii_audio, redact_pii_audio_quality: redact_pii_audio_quality, redact_pii_policies: redact_pii_policies, redact_pii_sub: redact_pii_sub, speaker_labels: speaker_labels, speakers_expected: speakers_expected, content_safety: content_safety, content_safety_confidence: content_safety_confidence, iab_categories: iab_categories, language_detection: language_detection, language_confidence_threshold: language_confidence_threshold, custom_spelling: custom_spelling, disfluencies: disfluencies, multichannel: multichannel, sentiment_analysis: sentiment_analysis, auto_chapters: auto_chapters, entity_detection: entity_detection, speech_threshold: speech_threshold, summarization: summarization, summary_model: summary_model, summary_type: summary_type, custom_topics: custom_topics, topics: topics, request_options: request_options)
        wait_until_ready(transcript_id: transcript.id, polling_options: polling_options).wait
      end
    end

    # Wait until the transcript is ready. The transcript is ready when the "status" is "completed".
    #
    # @param transcript_id [String] ID of the transcript
    # @param polling_options [PollingOptions]
    # @return [Transcripts::Transcript]
    def wait_until_ready(transcript_id:, polling_options: Transcripts::PollingOptions.new)
      Async do
        start_time = Time.now
        timeout_in_seconds = polling_options.timeout / 1000 if polling_options.timeout.positive?
        loop do
          transcript = get(transcript_id: transcript_id)
          if transcript.status == Transcripts::TranscriptStatus::COMPLETED || transcript.status == Transcripts::TranscriptStatus::ERROR
            return transcript
          elsif polling_options.timeout.positive? && Time.now - start_time > timeout_in_seconds
            raise StandardError, "Polling timeout"
          end

          sleep polling_options.interval / 1000
        end
      end
    end
  end
end
