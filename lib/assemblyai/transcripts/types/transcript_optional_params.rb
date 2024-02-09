# frozen_string_literal: true

require_relative "speech_model"
require_relative "transcript_language_code"
require_relative "transcript_boost_param"
require_relative "redact_pii_audio_quality"
require_relative "pii_policy"
require_relative "substitution_policy"
require_relative "transcript_custom_spelling"
require_relative "summary_model"
require_relative "summary_type"
require "json"

module AssemblyAI
  class Transcripts
    # The parameters for creating a transcript
    class TranscriptOptionalParams
      attr_reader :speech_model, :language_code, :punctuate, :format_text, :dual_channel, :webhook_url,
                  :webhook_auth_header_name, :webhook_auth_header_value, :auto_highlights, :audio_start_from, :audio_end_at, :word_boost, :boost_param, :filter_profanity, :redact_pii, :redact_pii_audio, :redact_pii_audio_quality, :redact_pii_policies, :redact_pii_sub, :speaker_labels, :speakers_expected, :content_safety, :content_safety_confidence, :iab_categories, :language_detection, :custom_spelling, :disfluencies, :sentiment_analysis, :auto_chapters, :entity_detection, :speech_threshold, :summarization, :summary_model, :summary_type, :custom_topics, :topics, :additional_properties

      # @param speech_model [Transcripts::SPEECH_MODEL]
      # @param language_code [TRANSCRIPT_LANGUAGE_CODE]
      # @param punctuate [Boolean] Enable Automatic Punctuation, can be true or false
      # @param format_text [Boolean] Enable Text Formatting, can be true or false
      # @param dual_channel [Boolean] Enable [Dual Channel](https://www.assemblyai.com/docs/models/speech-recognition#dual-channel-transcription) transcription, can be true or false.
      # @param webhook_url [String] The URL to which AssemblyAI send webhooks upon trancription completion
      # @param webhook_auth_header_name [String] The header name which should be sent back with webhook calls
      # @param webhook_auth_header_value [String] Specify a header name and value to send back with a webhook call for added security
      # @param auto_highlights [Boolean] Whether Key Phrases is enabled, either true or false
      # @param audio_start_from [Integer] The point in time, in milliseconds, to begin transcribing in your media file
      # @param audio_end_at [Integer] The point in time, in milliseconds, to stop transcribing in your media file
      # @param word_boost [Array<String>] The list of custom vocabulary to boost transcription probability for
      # @param boost_param [TRANSCRIPT_BOOST_PARAM] The word boost parameter value
      # @param filter_profanity [Boolean] Filter profanity from the transcribed text, can be true or false
      # @param redact_pii [Boolean] Redact PII from the transcribed text using the Redact PII model, can be true or false
      # @param redact_pii_audio [Boolean] Generate a copy of the original media file with spoken PII "beeped" out, can be true or false. See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more details.
      # @param redact_pii_audio_quality [REDACT_PII_AUDIO_QUALITY] Controls the filetype of the audio created by redact_pii_audio. Currently supports mp3 (default) and wav. See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more details.
      # @param redact_pii_policies [Array<Transcripts::PII_POLICY>] The list of PII Redaction policies to enable. See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more details.
      # @param redact_pii_sub [SUBSTITUTION_POLICY]
      # @param speaker_labels [Boolean] Enable [Speaker diarization](https://www.assemblyai.com/docs/models/speaker-diarization), can be true or false
      # @param speakers_expected [Integer] Tells the speaker label model how many speakers it should attempt to identify, up to 10. See [Speaker diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for more details.
      # @param content_safety [Boolean] Enable [Content Moderation](https://www.assemblyai.com/docs/models/content-moderation), can be true or false
      # @param content_safety_confidence [Integer] The confidence threshold for content moderation. Values must be between 25 and 100.
      # @param iab_categories [Boolean] Enable [Topic Detection](https://www.assemblyai.com/docs/models/topic-detection), can be true or false
      # @param language_detection [Boolean] Whether [Automatic language detection](https://www.assemblyai.com/docs/models/speech-recognition#automatic-language-detection) was enabled in the transcription request, either true or false.
      # @param custom_spelling [Array<Transcripts::TranscriptCustomSpelling>] Customize how words are spelled and formatted using to and from values
      # @param disfluencies [Boolean] Transcribe Filler Words, like "umm", in your media file; can be true or false
      # @param sentiment_analysis [Boolean] Enable [Sentiment Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis), can be true or false
      # @param auto_chapters [Boolean] Enable [Auto Chapters](https://www.assemblyai.com/docs/models/auto-chapters), can be true or false
      # @param entity_detection [Boolean] Enable [Entity Detection](https://www.assemblyai.com/docs/models/entity-detection), can be true or false
      # @param speech_threshold [Float] Reject audio files that contain less than this fraction of speech.
      #   Valid values are in the range [0, 1] inclusive.
      # @param summarization [Boolean] Enable [Summarization](https://www.assemblyai.com/docs/models/summarization), can be true or false
      # @param summary_model [SUMMARY_MODEL] The model to summarize the transcript
      # @param summary_type [SUMMARY_TYPE] The type of summary
      # @param custom_topics [Boolean] Whether custom topics is enabled, either true or false
      # @param topics [Array<String>] The list of custom topics provided, if custom topics is enabled
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::TranscriptOptionalParams]
      def initialize(speech_model: nil, language_code: nil, punctuate: nil, format_text: nil, dual_channel: nil,
                     webhook_url: nil, webhook_auth_header_name: nil, webhook_auth_header_value: nil, auto_highlights: nil, audio_start_from: nil, audio_end_at: nil, word_boost: nil, boost_param: nil, filter_profanity: nil, redact_pii: nil, redact_pii_audio: nil, redact_pii_audio_quality: nil, redact_pii_policies: nil, redact_pii_sub: nil, speaker_labels: nil, speakers_expected: nil, content_safety: nil, content_safety_confidence: nil, iab_categories: nil, language_detection: nil, custom_spelling: nil, disfluencies: nil, sentiment_analysis: nil, auto_chapters: nil, entity_detection: nil, speech_threshold: nil, summarization: nil, summary_model: nil, summary_type: nil, custom_topics: nil, topics: nil, additional_properties: nil)
        # @type [Transcripts::SPEECH_MODEL]
        @speech_model = speech_model
        # @type [TRANSCRIPT_LANGUAGE_CODE]
        @language_code = language_code
        # @type [Boolean] Enable Automatic Punctuation, can be true or false
        @punctuate = punctuate
        # @type [Boolean] Enable Text Formatting, can be true or false
        @format_text = format_text
        # @type [Boolean] Enable [Dual Channel](https://www.assemblyai.com/docs/models/speech-recognition#dual-channel-transcription) transcription, can be true or false.
        @dual_channel = dual_channel
        # @type [String] The URL to which AssemblyAI send webhooks upon trancription completion
        @webhook_url = webhook_url
        # @type [String] The header name which should be sent back with webhook calls
        @webhook_auth_header_name = webhook_auth_header_name
        # @type [String] Specify a header name and value to send back with a webhook call for added security
        @webhook_auth_header_value = webhook_auth_header_value
        # @type [Boolean] Whether Key Phrases is enabled, either true or false
        @auto_highlights = auto_highlights
        # @type [Integer] The point in time, in milliseconds, to begin transcribing in your media file
        @audio_start_from = audio_start_from
        # @type [Integer] The point in time, in milliseconds, to stop transcribing in your media file
        @audio_end_at = audio_end_at
        # @type [Array<String>] The list of custom vocabulary to boost transcription probability for
        @word_boost = word_boost
        # @type [TRANSCRIPT_BOOST_PARAM] The word boost parameter value
        @boost_param = boost_param
        # @type [Boolean] Filter profanity from the transcribed text, can be true or false
        @filter_profanity = filter_profanity
        # @type [Boolean] Redact PII from the transcribed text using the Redact PII model, can be true or false
        @redact_pii = redact_pii
        # @type [Boolean] Generate a copy of the original media file with spoken PII "beeped" out, can be true or false. See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more details.
        @redact_pii_audio = redact_pii_audio
        # @type [REDACT_PII_AUDIO_QUALITY] Controls the filetype of the audio created by redact_pii_audio. Currently supports mp3 (default) and wav. See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more details.
        @redact_pii_audio_quality = redact_pii_audio_quality
        # @type [Array<Transcripts::PII_POLICY>] The list of PII Redaction policies to enable. See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more details.
        @redact_pii_policies = redact_pii_policies
        # @type [SUBSTITUTION_POLICY]
        @redact_pii_sub = redact_pii_sub
        # @type [Boolean] Enable [Speaker diarization](https://www.assemblyai.com/docs/models/speaker-diarization), can be true or false
        @speaker_labels = speaker_labels
        # @type [Integer] Tells the speaker label model how many speakers it should attempt to identify, up to 10. See [Speaker diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for more details.
        @speakers_expected = speakers_expected
        # @type [Boolean] Enable [Content Moderation](https://www.assemblyai.com/docs/models/content-moderation), can be true or false
        @content_safety = content_safety
        # @type [Integer] The confidence threshold for content moderation. Values must be between 25 and 100.
        @content_safety_confidence = content_safety_confidence
        # @type [Boolean] Enable [Topic Detection](https://www.assemblyai.com/docs/models/topic-detection), can be true or false
        @iab_categories = iab_categories
        # @type [Boolean] Whether [Automatic language detection](https://www.assemblyai.com/docs/models/speech-recognition#automatic-language-detection) was enabled in the transcription request, either true or false.
        @language_detection = language_detection
        # @type [Array<Transcripts::TranscriptCustomSpelling>] Customize how words are spelled and formatted using to and from values
        @custom_spelling = custom_spelling
        # @type [Boolean] Transcribe Filler Words, like "umm", in your media file; can be true or false
        @disfluencies = disfluencies
        # @type [Boolean] Enable [Sentiment Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis), can be true or false
        @sentiment_analysis = sentiment_analysis
        # @type [Boolean] Enable [Auto Chapters](https://www.assemblyai.com/docs/models/auto-chapters), can be true or false
        @auto_chapters = auto_chapters
        # @type [Boolean] Enable [Entity Detection](https://www.assemblyai.com/docs/models/entity-detection), can be true or false
        @entity_detection = entity_detection
        # @type [Float] Reject audio files that contain less than this fraction of speech.
        #   Valid values are in the range [0, 1] inclusive.
        @speech_threshold = speech_threshold
        # @type [Boolean] Enable [Summarization](https://www.assemblyai.com/docs/models/summarization), can be true or false
        @summarization = summarization
        # @type [SUMMARY_MODEL] The model to summarize the transcript
        @summary_model = summary_model
        # @type [SUMMARY_TYPE] The type of summary
        @summary_type = summary_type
        # @type [Boolean] Whether custom topics is enabled, either true or false
        @custom_topics = custom_topics
        # @type [Array<String>] The list of custom topics provided, if custom topics is enabled
        @topics = topics
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TranscriptOptionalParams
      #
      # @param json_object [JSON]
      # @return [Transcripts::TranscriptOptionalParams]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        speech_model = struct.speech_model
        language_code = Transcripts::TRANSCRIPT_LANGUAGE_CODE.key(parsed_json["language_code"]) || parsed_json["language_code"]
        punctuate = struct.punctuate
        format_text = struct.format_text
        dual_channel = struct.dual_channel
        webhook_url = struct.webhook_url
        webhook_auth_header_name = struct.webhook_auth_header_name
        webhook_auth_header_value = struct.webhook_auth_header_value
        auto_highlights = struct.auto_highlights
        audio_start_from = struct.audio_start_from
        audio_end_at = struct.audio_end_at
        word_boost = struct.word_boost
        boost_param = Transcripts::TRANSCRIPT_BOOST_PARAM.key(parsed_json["boost_param"]) || parsed_json["boost_param"]
        filter_profanity = struct.filter_profanity
        redact_pii = struct.redact_pii
        redact_pii_audio = struct.redact_pii_audio
        redact_pii_audio_quality = Transcripts::REDACT_PII_AUDIO_QUALITY.key(parsed_json["redact_pii_audio_quality"]) || parsed_json["redact_pii_audio_quality"]
        redact_pii_policies = parsed_json["redact_pii_policies"]&.map do |v|
          v = v.to_json
          Transcripts::PII_POLICY.key(v) || v
        end
        redact_pii_sub = Transcripts::SUBSTITUTION_POLICY.key(parsed_json["redact_pii_sub"]) || parsed_json["redact_pii_sub"]
        speaker_labels = struct.speaker_labels
        speakers_expected = struct.speakers_expected
        content_safety = struct.content_safety
        content_safety_confidence = struct.content_safety_confidence
        iab_categories = struct.iab_categories
        language_detection = struct.language_detection
        custom_spelling = parsed_json["custom_spelling"]&.map do |v|
          v = v.to_json
          Transcripts::TranscriptCustomSpelling.from_json(json_object: v)
        end
        disfluencies = struct.disfluencies
        sentiment_analysis = struct.sentiment_analysis
        auto_chapters = struct.auto_chapters
        entity_detection = struct.entity_detection
        speech_threshold = struct.speech_threshold
        summarization = struct.summarization
        summary_model = Transcripts::SUMMARY_MODEL.key(parsed_json["summary_model"]) || parsed_json["summary_model"]
        summary_type = Transcripts::SUMMARY_TYPE.key(parsed_json["summary_type"]) || parsed_json["summary_type"]
        custom_topics = struct.custom_topics
        topics = struct.topics
        new(speech_model: speech_model, language_code: language_code, punctuate: punctuate, format_text: format_text,
            dual_channel: dual_channel, webhook_url: webhook_url, webhook_auth_header_name: webhook_auth_header_name, webhook_auth_header_value: webhook_auth_header_value, auto_highlights: auto_highlights, audio_start_from: audio_start_from, audio_end_at: audio_end_at, word_boost: word_boost, boost_param: boost_param, filter_profanity: filter_profanity, redact_pii: redact_pii, redact_pii_audio: redact_pii_audio, redact_pii_audio_quality: redact_pii_audio_quality, redact_pii_policies: redact_pii_policies, redact_pii_sub: redact_pii_sub, speaker_labels: speaker_labels, speakers_expected: speakers_expected, content_safety: content_safety, content_safety_confidence: content_safety_confidence, iab_categories: iab_categories, language_detection: language_detection, custom_spelling: custom_spelling, disfluencies: disfluencies, sentiment_analysis: sentiment_analysis, auto_chapters: auto_chapters, entity_detection: entity_detection, speech_threshold: speech_threshold, summarization: summarization, summary_model: summary_model, summary_type: summary_type, custom_topics: custom_topics, topics: topics, additional_properties: struct)
      end

      # Serialize an instance of TranscriptOptionalParams to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "speech_model": @speech_model,
          "language_code": Transcripts::TRANSCRIPT_LANGUAGE_CODE[@language_code] || @language_code,
          "punctuate": @punctuate,
          "format_text": @format_text,
          "dual_channel": @dual_channel,
          "webhook_url": @webhook_url,
          "webhook_auth_header_name": @webhook_auth_header_name,
          "webhook_auth_header_value": @webhook_auth_header_value,
          "auto_highlights": @auto_highlights,
          "audio_start_from": @audio_start_from,
          "audio_end_at": @audio_end_at,
          "word_boost": @word_boost,
          "boost_param": Transcripts::TRANSCRIPT_BOOST_PARAM[@boost_param] || @boost_param,
          "filter_profanity": @filter_profanity,
          "redact_pii": @redact_pii,
          "redact_pii_audio": @redact_pii_audio,
          "redact_pii_audio_quality": Transcripts::REDACT_PII_AUDIO_QUALITY[@redact_pii_audio_quality] || @redact_pii_audio_quality,
          "redact_pii_policies": @redact_pii_policies,
          "redact_pii_sub": Transcripts::SUBSTITUTION_POLICY[@redact_pii_sub] || @redact_pii_sub,
          "speaker_labels": @speaker_labels,
          "speakers_expected": @speakers_expected,
          "content_safety": @content_safety,
          "content_safety_confidence": @content_safety_confidence,
          "iab_categories": @iab_categories,
          "language_detection": @language_detection,
          "custom_spelling": @custom_spelling,
          "disfluencies": @disfluencies,
          "sentiment_analysis": @sentiment_analysis,
          "auto_chapters": @auto_chapters,
          "entity_detection": @entity_detection,
          "speech_threshold": @speech_threshold,
          "summarization": @summarization,
          "summary_model": Transcripts::SUMMARY_MODEL[@summary_model] || @summary_model,
          "summary_type": Transcripts::SUMMARY_TYPE[@summary_type] || @summary_type,
          "custom_topics": @custom_topics,
          "topics": @topics
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.speech_model&.is_a?(String) != false || raise("Passed value for field obj.speech_model is not the expected type, validation failed.")
        obj.language_code&.is_a?(Transcripts::TRANSCRIPT_LANGUAGE_CODE) != false || raise("Passed value for field obj.language_code is not the expected type, validation failed.")
        obj.punctuate&.is_a?(Boolean) != false || raise("Passed value for field obj.punctuate is not the expected type, validation failed.")
        obj.format_text&.is_a?(Boolean) != false || raise("Passed value for field obj.format_text is not the expected type, validation failed.")
        obj.dual_channel&.is_a?(Boolean) != false || raise("Passed value for field obj.dual_channel is not the expected type, validation failed.")
        obj.webhook_url&.is_a?(String) != false || raise("Passed value for field obj.webhook_url is not the expected type, validation failed.")
        obj.webhook_auth_header_name&.is_a?(String) != false || raise("Passed value for field obj.webhook_auth_header_name is not the expected type, validation failed.")
        obj.webhook_auth_header_value&.is_a?(String) != false || raise("Passed value for field obj.webhook_auth_header_value is not the expected type, validation failed.")
        obj.auto_highlights&.is_a?(Boolean) != false || raise("Passed value for field obj.auto_highlights is not the expected type, validation failed.")
        obj.audio_start_from&.is_a?(Integer) != false || raise("Passed value for field obj.audio_start_from is not the expected type, validation failed.")
        obj.audio_end_at&.is_a?(Integer) != false || raise("Passed value for field obj.audio_end_at is not the expected type, validation failed.")
        obj.word_boost&.is_a?(Array) != false || raise("Passed value for field obj.word_boost is not the expected type, validation failed.")
        obj.boost_param&.is_a?(Transcripts::TRANSCRIPT_BOOST_PARAM) != false || raise("Passed value for field obj.boost_param is not the expected type, validation failed.")
        obj.filter_profanity&.is_a?(Boolean) != false || raise("Passed value for field obj.filter_profanity is not the expected type, validation failed.")
        obj.redact_pii&.is_a?(Boolean) != false || raise("Passed value for field obj.redact_pii is not the expected type, validation failed.")
        obj.redact_pii_audio&.is_a?(Boolean) != false || raise("Passed value for field obj.redact_pii_audio is not the expected type, validation failed.")
        obj.redact_pii_audio_quality&.is_a?(Transcripts::REDACT_PII_AUDIO_QUALITY) != false || raise("Passed value for field obj.redact_pii_audio_quality is not the expected type, validation failed.")
        obj.redact_pii_policies&.is_a?(Array) != false || raise("Passed value for field obj.redact_pii_policies is not the expected type, validation failed.")
        obj.redact_pii_sub&.is_a?(Transcripts::SUBSTITUTION_POLICY) != false || raise("Passed value for field obj.redact_pii_sub is not the expected type, validation failed.")
        obj.speaker_labels&.is_a?(Boolean) != false || raise("Passed value for field obj.speaker_labels is not the expected type, validation failed.")
        obj.speakers_expected&.is_a?(Integer) != false || raise("Passed value for field obj.speakers_expected is not the expected type, validation failed.")
        obj.content_safety&.is_a?(Boolean) != false || raise("Passed value for field obj.content_safety is not the expected type, validation failed.")
        obj.content_safety_confidence&.is_a?(Integer) != false || raise("Passed value for field obj.content_safety_confidence is not the expected type, validation failed.")
        obj.iab_categories&.is_a?(Boolean) != false || raise("Passed value for field obj.iab_categories is not the expected type, validation failed.")
        obj.language_detection&.is_a?(Boolean) != false || raise("Passed value for field obj.language_detection is not the expected type, validation failed.")
        obj.custom_spelling&.is_a?(Array) != false || raise("Passed value for field obj.custom_spelling is not the expected type, validation failed.")
        obj.disfluencies&.is_a?(Boolean) != false || raise("Passed value for field obj.disfluencies is not the expected type, validation failed.")
        obj.sentiment_analysis&.is_a?(Boolean) != false || raise("Passed value for field obj.sentiment_analysis is not the expected type, validation failed.")
        obj.auto_chapters&.is_a?(Boolean) != false || raise("Passed value for field obj.auto_chapters is not the expected type, validation failed.")
        obj.entity_detection&.is_a?(Boolean) != false || raise("Passed value for field obj.entity_detection is not the expected type, validation failed.")
        obj.speech_threshold&.is_a?(Float) != false || raise("Passed value for field obj.speech_threshold is not the expected type, validation failed.")
        obj.summarization&.is_a?(Boolean) != false || raise("Passed value for field obj.summarization is not the expected type, validation failed.")
        obj.summary_model&.is_a?(Transcripts::SUMMARY_MODEL) != false || raise("Passed value for field obj.summary_model is not the expected type, validation failed.")
        obj.summary_type&.is_a?(Transcripts::SUMMARY_TYPE) != false || raise("Passed value for field obj.summary_type is not the expected type, validation failed.")
        obj.custom_topics&.is_a?(Boolean) != false || raise("Passed value for field obj.custom_topics is not the expected type, validation failed.")
        obj.topics&.is_a?(Array) != false || raise("Passed value for field obj.topics is not the expected type, validation failed.")
      end
    end
  end
end
