# frozen_string_literal: true

require_relative "transcript_language_code"
require_relative "speech_model"
require_relative "transcript_boost_param"
require_relative "redact_pii_audio_quality"
require_relative "pii_policy"
require_relative "substitution_policy"
require_relative "transcript_custom_spelling"
require_relative "summary_model"
require_relative "summary_type"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # The parameters for creating a transcript
    class TranscriptOptionalParams
      # @return [AssemblyAI::Transcripts::TranscriptLanguageCode]
      attr_reader :language_code
      # @return [Boolean] Enable Automatic Punctuation, can be true or false
      attr_reader :punctuate
      # @return [Boolean] Enable Text Formatting, can be true or false
      attr_reader :format_text
      # @return [Boolean] Enable [Dual
      #  ://www.assemblyai.com/docs/models/speech-recognition#dual-channel-transcription)
      #  transcription, can be true or false.
      attr_reader :dual_channel
      # @return [AssemblyAI::Transcripts::SpeechModel]
      attr_reader :speech_model
      # @return [String] The URL to which we send webhook requests. We sends two different types of
      #  webhook requests. One request when a transcript is completed or failed, and one
      #  request when the redacted audio is ready if redact_pii_audio is enabled.
      attr_reader :webhook_url
      # @return [String] The header name to be sent with the transcript completed or failed webhook
      #  requests
      attr_reader :webhook_auth_header_name
      # @return [String] The header value to send back with the transcript completed or failed webhook
      #  requests for added security
      attr_reader :webhook_auth_header_value
      # @return [Boolean] Enable Key Phrases, either true or false
      attr_reader :auto_highlights
      # @return [Integer] The point in time, in milliseconds, to begin transcribing in your media file
      attr_reader :audio_start_from
      # @return [Integer] The point in time, in milliseconds, to stop transcribing in your media file
      attr_reader :audio_end_at
      # @return [Array<String>] The list of custom vocabulary to boost transcription probability for
      attr_reader :word_boost
      # @return [AssemblyAI::Transcripts::TranscriptBoostParam] The word boost parameter value
      attr_reader :boost_param
      # @return [Boolean] Filter profanity from the transcribed text, can be true or false
      attr_reader :filter_profanity
      # @return [Boolean] Redact PII from the transcribed text using the Redact PII model, can be true or
      #  false
      attr_reader :redact_pii
      # @return [Boolean] Generate a copy of the original media file with spoken PII "beeped" out, can be
      #  true or false. See [PII
      #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
      #  details.
      attr_reader :redact_pii_audio
      # @return [AssemblyAI::Transcripts::RedactPiiAudioQuality] Controls the filetype of the audio created by redact_pii_audio. Currently
      #  supports mp3 (default) and wav. See [PII
      #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
      #  details.
      attr_reader :redact_pii_audio_quality
      # @return [Array<AssemblyAI::Transcripts::PiiPolicy>] The list of PII Redaction policies to enable. See [PII
      #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
      #  details.
      attr_reader :redact_pii_policies
      # @return [AssemblyAI::Transcripts::SubstitutionPolicy]
      attr_reader :redact_pii_sub
      # @return [Boolean] Enable [Speaker
      #  diarization](https://www.assemblyai.com/docs/models/speaker-diarization), can be
      #  true or false
      attr_reader :speaker_labels
      # @return [Integer] Tells the speaker label model how many speakers it should attempt to identify,
      #  up to 10. See [Speaker
      #  diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for
      #  more details.
      attr_reader :speakers_expected
      # @return [Boolean] Enable [Content
      #  Moderation](https://www.assemblyai.com/docs/models/content-moderation), can be
      #  true or false
      attr_reader :content_safety
      # @return [Integer] The confidence threshold for the Content Moderation model. Values must be
      #  between 25 and 100.
      attr_reader :content_safety_confidence
      # @return [Boolean] Enable [Topic
      #  Detection](https://www.assemblyai.com/docs/models/topic-detection), can be true
      #  or false
      attr_reader :iab_categories
      # @return [Boolean] Enable [Automatic language
      #  www.assemblyai.com/docs/models/speech-recognition#automatic-language-detection),
      #  either true or false.
      attr_reader :language_detection
      # @return [Array<AssemblyAI::Transcripts::TranscriptCustomSpelling>] Customize how words are spelled and formatted using to and from values
      attr_reader :custom_spelling
      # @return [Boolean] Transcribe Filler Words, like "umm", in your media file; can be true or false
      attr_reader :disfluencies
      # @return [Boolean] Enable [Sentiment
      #  Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis), can be
      #  true or false
      attr_reader :sentiment_analysis
      # @return [Boolean] Enable [Auto Chapters](https://www.assemblyai.com/docs/models/auto-chapters),
      #  can be true or false
      attr_reader :auto_chapters
      # @return [Boolean] Enable [Entity
      #  Detection](https://www.assemblyai.com/docs/models/entity-detection), can be true
      #  or false
      attr_reader :entity_detection
      # @return [Float] Reject audio files that contain less than this fraction of speech.
      #  Valid values are in the range [0, 1] inclusive.
      attr_reader :speech_threshold
      # @return [Boolean] Enable [Summarization](https://www.assemblyai.com/docs/models/summarization),
      #  can be true or false
      attr_reader :summarization
      # @return [AssemblyAI::Transcripts::SummaryModel] The model to summarize the transcript
      attr_reader :summary_model
      # @return [AssemblyAI::Transcripts::SummaryType] The type of summary
      attr_reader :summary_type
      # @return [Boolean] Enable custom topics, either true or false
      attr_reader :custom_topics
      # @return [Array<String>] The list of custom topics
      attr_reader :topics
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param language_code [AssemblyAI::Transcripts::TranscriptLanguageCode]
      # @param punctuate [Boolean] Enable Automatic Punctuation, can be true or false
      # @param format_text [Boolean] Enable Text Formatting, can be true or false
      # @param dual_channel [Boolean] Enable [Dual
      #  ://www.assemblyai.com/docs/models/speech-recognition#dual-channel-transcription)
      #  transcription, can be true or false.
      # @param speech_model [AssemblyAI::Transcripts::SpeechModel]
      # @param webhook_url [String] The URL to which we send webhook requests. We sends two different types of
      #  webhook requests. One request when a transcript is completed or failed, and one
      #  request when the redacted audio is ready if redact_pii_audio is enabled.
      # @param webhook_auth_header_name [String] The header name to be sent with the transcript completed or failed webhook
      #  requests
      # @param webhook_auth_header_value [String] The header value to send back with the transcript completed or failed webhook
      #  requests for added security
      # @param auto_highlights [Boolean] Enable Key Phrases, either true or false
      # @param audio_start_from [Integer] The point in time, in milliseconds, to begin transcribing in your media file
      # @param audio_end_at [Integer] The point in time, in milliseconds, to stop transcribing in your media file
      # @param word_boost [Array<String>] The list of custom vocabulary to boost transcription probability for
      # @param boost_param [AssemblyAI::Transcripts::TranscriptBoostParam] The word boost parameter value
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
      # @param language_detection [Boolean] Enable [Automatic language
      #  www.assemblyai.com/docs/models/speech-recognition#automatic-language-detection),
      #  either true or false.
      # @param custom_spelling [Array<AssemblyAI::Transcripts::TranscriptCustomSpelling>] Customize how words are spelled and formatted using to and from values
      # @param disfluencies [Boolean] Transcribe Filler Words, like "umm", in your media file; can be true or false
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
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TranscriptOptionalParams]
      def initialize(language_code: OMIT, punctuate: OMIT, format_text: OMIT, dual_channel: OMIT, speech_model: OMIT,
                     webhook_url: OMIT, webhook_auth_header_name: OMIT, webhook_auth_header_value: OMIT, auto_highlights: OMIT, audio_start_from: OMIT, audio_end_at: OMIT, word_boost: OMIT, boost_param: OMIT, filter_profanity: OMIT, redact_pii: OMIT, redact_pii_audio: OMIT, redact_pii_audio_quality: OMIT, redact_pii_policies: OMIT, redact_pii_sub: OMIT, speaker_labels: OMIT, speakers_expected: OMIT, content_safety: OMIT, content_safety_confidence: OMIT, iab_categories: OMIT, language_detection: OMIT, custom_spelling: OMIT, disfluencies: OMIT, sentiment_analysis: OMIT, auto_chapters: OMIT, entity_detection: OMIT, speech_threshold: OMIT, summarization: OMIT, summary_model: OMIT, summary_type: OMIT, custom_topics: OMIT, topics: OMIT, additional_properties: nil)
        @language_code = language_code if language_code != OMIT
        @punctuate = punctuate if punctuate != OMIT
        @format_text = format_text if format_text != OMIT
        @dual_channel = dual_channel if dual_channel != OMIT
        @speech_model = speech_model if speech_model != OMIT
        @webhook_url = webhook_url if webhook_url != OMIT
        @webhook_auth_header_name = webhook_auth_header_name if webhook_auth_header_name != OMIT
        @webhook_auth_header_value = webhook_auth_header_value if webhook_auth_header_value != OMIT
        @auto_highlights = auto_highlights if auto_highlights != OMIT
        @audio_start_from = audio_start_from if audio_start_from != OMIT
        @audio_end_at = audio_end_at if audio_end_at != OMIT
        @word_boost = word_boost if word_boost != OMIT
        @boost_param = boost_param if boost_param != OMIT
        @filter_profanity = filter_profanity if filter_profanity != OMIT
        @redact_pii = redact_pii if redact_pii != OMIT
        @redact_pii_audio = redact_pii_audio if redact_pii_audio != OMIT
        @redact_pii_audio_quality = redact_pii_audio_quality if redact_pii_audio_quality != OMIT
        @redact_pii_policies = redact_pii_policies if redact_pii_policies != OMIT
        @redact_pii_sub = redact_pii_sub if redact_pii_sub != OMIT
        @speaker_labels = speaker_labels if speaker_labels != OMIT
        @speakers_expected = speakers_expected if speakers_expected != OMIT
        @content_safety = content_safety if content_safety != OMIT
        @content_safety_confidence = content_safety_confidence if content_safety_confidence != OMIT
        @iab_categories = iab_categories if iab_categories != OMIT
        @language_detection = language_detection if language_detection != OMIT
        @custom_spelling = custom_spelling if custom_spelling != OMIT
        @disfluencies = disfluencies if disfluencies != OMIT
        @sentiment_analysis = sentiment_analysis if sentiment_analysis != OMIT
        @auto_chapters = auto_chapters if auto_chapters != OMIT
        @entity_detection = entity_detection if entity_detection != OMIT
        @speech_threshold = speech_threshold if speech_threshold != OMIT
        @summarization = summarization if summarization != OMIT
        @summary_model = summary_model if summary_model != OMIT
        @summary_type = summary_type if summary_type != OMIT
        @custom_topics = custom_topics if custom_topics != OMIT
        @topics = topics if topics != OMIT
        @additional_properties = additional_properties
        @_field_set = {
          "language_code": language_code,
          "punctuate": punctuate,
          "format_text": format_text,
          "dual_channel": dual_channel,
          "speech_model": speech_model,
          "webhook_url": webhook_url,
          "webhook_auth_header_name": webhook_auth_header_name,
          "webhook_auth_header_value": webhook_auth_header_value,
          "auto_highlights": auto_highlights,
          "audio_start_from": audio_start_from,
          "audio_end_at": audio_end_at,
          "word_boost": word_boost,
          "boost_param": boost_param,
          "filter_profanity": filter_profanity,
          "redact_pii": redact_pii,
          "redact_pii_audio": redact_pii_audio,
          "redact_pii_audio_quality": redact_pii_audio_quality,
          "redact_pii_policies": redact_pii_policies,
          "redact_pii_sub": redact_pii_sub,
          "speaker_labels": speaker_labels,
          "speakers_expected": speakers_expected,
          "content_safety": content_safety,
          "content_safety_confidence": content_safety_confidence,
          "iab_categories": iab_categories,
          "language_detection": language_detection,
          "custom_spelling": custom_spelling,
          "disfluencies": disfluencies,
          "sentiment_analysis": sentiment_analysis,
          "auto_chapters": auto_chapters,
          "entity_detection": entity_detection,
          "speech_threshold": speech_threshold,
          "summarization": summarization,
          "summary_model": summary_model,
          "summary_type": summary_type,
          "custom_topics": custom_topics,
          "topics": topics
        }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of TranscriptOptionalParams
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TranscriptOptionalParams]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        language_code = parsed_json["language_code"]
        punctuate = parsed_json["punctuate"]
        format_text = parsed_json["format_text"]
        dual_channel = parsed_json["dual_channel"]
        speech_model = parsed_json["speech_model"]
        webhook_url = parsed_json["webhook_url"]
        webhook_auth_header_name = parsed_json["webhook_auth_header_name"]
        webhook_auth_header_value = parsed_json["webhook_auth_header_value"]
        auto_highlights = parsed_json["auto_highlights"]
        audio_start_from = parsed_json["audio_start_from"]
        audio_end_at = parsed_json["audio_end_at"]
        word_boost = parsed_json["word_boost"]
        boost_param = parsed_json["boost_param"]
        filter_profanity = parsed_json["filter_profanity"]
        redact_pii = parsed_json["redact_pii"]
        redact_pii_audio = parsed_json["redact_pii_audio"]
        redact_pii_audio_quality = parsed_json["redact_pii_audio_quality"]
        redact_pii_policies = parsed_json["redact_pii_policies"]
        redact_pii_sub = parsed_json["redact_pii_sub"]
        speaker_labels = parsed_json["speaker_labels"]
        speakers_expected = parsed_json["speakers_expected"]
        content_safety = parsed_json["content_safety"]
        content_safety_confidence = parsed_json["content_safety_confidence"]
        iab_categories = parsed_json["iab_categories"]
        language_detection = parsed_json["language_detection"]
        custom_spelling = parsed_json["custom_spelling"]&.map do |item|
          item = item.to_json
          AssemblyAI::Transcripts::TranscriptCustomSpelling.from_json(json_object: item)
        end
        disfluencies = parsed_json["disfluencies"]
        sentiment_analysis = parsed_json["sentiment_analysis"]
        auto_chapters = parsed_json["auto_chapters"]
        entity_detection = parsed_json["entity_detection"]
        speech_threshold = parsed_json["speech_threshold"]
        summarization = parsed_json["summarization"]
        summary_model = parsed_json["summary_model"]
        summary_type = parsed_json["summary_type"]
        custom_topics = parsed_json["custom_topics"]
        topics = parsed_json["topics"]
        new(
          language_code: language_code,
          punctuate: punctuate,
          format_text: format_text,
          dual_channel: dual_channel,
          speech_model: speech_model,
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
          language_detection: language_detection,
          custom_spelling: custom_spelling,
          disfluencies: disfluencies,
          sentiment_analysis: sentiment_analysis,
          auto_chapters: auto_chapters,
          entity_detection: entity_detection,
          speech_threshold: speech_threshold,
          summarization: summarization,
          summary_model: summary_model,
          summary_type: summary_type,
          custom_topics: custom_topics,
          topics: topics,
          additional_properties: struct
        )
      end

      # Serialize an instance of TranscriptOptionalParams to a JSON object
      #
      # @return [String]
      def to_json(*_args)
        @_field_set&.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given
      #  hash and check each fields type against the current object's property
      #  definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.language_code&.is_a?(AssemblyAI::Transcripts::TranscriptLanguageCode) != false || raise("Passed value for field obj.language_code is not the expected type, validation failed.")
        obj.punctuate&.is_a?(Boolean) != false || raise("Passed value for field obj.punctuate is not the expected type, validation failed.")
        obj.format_text&.is_a?(Boolean) != false || raise("Passed value for field obj.format_text is not the expected type, validation failed.")
        obj.dual_channel&.is_a?(Boolean) != false || raise("Passed value for field obj.dual_channel is not the expected type, validation failed.")
        obj.speech_model&.is_a?(AssemblyAI::Transcripts::SpeechModel) != false || raise("Passed value for field obj.speech_model is not the expected type, validation failed.")
        obj.webhook_url&.is_a?(String) != false || raise("Passed value for field obj.webhook_url is not the expected type, validation failed.")
        obj.webhook_auth_header_name&.is_a?(String) != false || raise("Passed value for field obj.webhook_auth_header_name is not the expected type, validation failed.")
        obj.webhook_auth_header_value&.is_a?(String) != false || raise("Passed value for field obj.webhook_auth_header_value is not the expected type, validation failed.")
        obj.auto_highlights&.is_a?(Boolean) != false || raise("Passed value for field obj.auto_highlights is not the expected type, validation failed.")
        obj.audio_start_from&.is_a?(Integer) != false || raise("Passed value for field obj.audio_start_from is not the expected type, validation failed.")
        obj.audio_end_at&.is_a?(Integer) != false || raise("Passed value for field obj.audio_end_at is not the expected type, validation failed.")
        obj.word_boost&.is_a?(Array) != false || raise("Passed value for field obj.word_boost is not the expected type, validation failed.")
        obj.boost_param&.is_a?(AssemblyAI::Transcripts::TranscriptBoostParam) != false || raise("Passed value for field obj.boost_param is not the expected type, validation failed.")
        obj.filter_profanity&.is_a?(Boolean) != false || raise("Passed value for field obj.filter_profanity is not the expected type, validation failed.")
        obj.redact_pii&.is_a?(Boolean) != false || raise("Passed value for field obj.redact_pii is not the expected type, validation failed.")
        obj.redact_pii_audio&.is_a?(Boolean) != false || raise("Passed value for field obj.redact_pii_audio is not the expected type, validation failed.")
        obj.redact_pii_audio_quality&.is_a?(AssemblyAI::Transcripts::RedactPiiAudioQuality) != false || raise("Passed value for field obj.redact_pii_audio_quality is not the expected type, validation failed.")
        obj.redact_pii_policies&.is_a?(Array) != false || raise("Passed value for field obj.redact_pii_policies is not the expected type, validation failed.")
        obj.redact_pii_sub&.is_a?(AssemblyAI::Transcripts::SubstitutionPolicy) != false || raise("Passed value for field obj.redact_pii_sub is not the expected type, validation failed.")
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
        obj.summary_model&.is_a?(AssemblyAI::Transcripts::SummaryModel) != false || raise("Passed value for field obj.summary_model is not the expected type, validation failed.")
        obj.summary_type&.is_a?(AssemblyAI::Transcripts::SummaryType) != false || raise("Passed value for field obj.summary_type is not the expected type, validation failed.")
        obj.custom_topics&.is_a?(Boolean) != false || raise("Passed value for field obj.custom_topics is not the expected type, validation failed.")
        obj.topics&.is_a?(Array) != false || raise("Passed value for field obj.topics is not the expected type, validation failed.")
      end
    end
  end
end
