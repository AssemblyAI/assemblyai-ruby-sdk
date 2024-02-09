# frozen_string_literal: true

require_relative "speech_model"
require_relative "transcript_status"
require_relative "transcript_language_code"
require_relative "transcript_word"
require_relative "transcript_utterance"
require_relative "auto_highlights_result"
require_relative "redact_pii_audio_quality"
require_relative "pii_policy"
require_relative "substitution_policy"
require_relative "content_safety_labels_result"
require_relative "topic_detection_model_result"
require_relative "transcript_custom_spelling"
require_relative "chapter"
require_relative "sentiment_analysis_result"
require_relative "entity"
require "json"

module AssemblyAI
  class Transcripts
    # A transcript object
    class Transcript
      attr_reader :id, :speech_model, :language_model, :acoustic_model, :status, :language_code, :audio_url, :text,
                  :words, :utterances, :confidence, :audio_duration, :punctuate, :format_text, :dual_channel, :webhook_url, :webhook_status_code, :webhook_auth, :webhook_auth_header_name, :speed_boost, :auto_highlights, :auto_highlights_result, :audio_start_from, :audio_end_at, :word_boost, :boost_param, :filter_profanity, :redact_pii, :redact_pii_audio, :redact_pii_audio_quality, :redact_pii_policies, :redact_pii_sub, :speaker_labels, :speakers_expected, :content_safety, :content_safety_labels, :iab_categories, :iab_categories_result, :language_detection, :custom_spelling, :auto_chapters, :chapters, :summarization, :summary_type, :summary_model, :summary, :custom_topics, :topics, :disfluencies, :sentiment_analysis, :sentiment_analysis_results, :entity_detection, :entities, :speech_threshold, :throttled, :error, :additional_properties

      # @param id [String] The unique identifier of your transcript
      # @param speech_model [Transcripts::SPEECH_MODEL]
      # @param language_model [String] The language model that was used for the transcript
      # @param acoustic_model [String] The acoustic model that was used for the transcript
      # @param status [TRANSCRIPT_STATUS] The status of your transcript. Possible values are queued, processing, completed, or error.
      # @param language_code [TRANSCRIPT_LANGUAGE_CODE] The language of your audio file.
      #   Possible values are found in [Supported Languages](https://www.assemblyai.com/docs/concepts/supported-languages).
      #   The default value is 'en_us'.
      # @param audio_url [String] The URL of the media that was transcribed
      # @param text [String] The textual transcript of your media file
      # @param words [Array<Transcripts::TranscriptWord>] An array of temporally-sequential word objects, one for each word in the transcript.
      #   See [Speech recognition](https://www.assemblyai.com/docs/models/speech-recognition) for more information.
      # @param utterances [Array<Transcripts::TranscriptUtterance>] When dual_channel or speaker_labels is enabled, a list of turn-by-turn utterance objects.
      #   See [Speaker diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for more information.
      # @param confidence [Float] The confidence score for the transcript, between 0.0 (low confidence) and 1.0 (high confidence)
      # @param audio_duration [Float] The duration of this transcript object's media file, in seconds
      # @param punctuate [Boolean] Whether Automatic Punctuation is enabled, either true or false
      # @param format_text [Boolean] Whether Text Formatting is enabled, either true or false
      # @param dual_channel [Boolean] Whether [Dual channel transcription](https://www.assemblyai.com/docs/models/speech-recognition#dual-channel-transcription) was enabled in the transcription request, either true or false
      # @param webhook_url [String] The URL to which we send webhooks upon trancription completion
      # @param webhook_status_code [Integer] The status code we received from your server when delivering your webhook, if a webhook URL was provided
      # @param webhook_auth [Boolean] Whether webhook authentication details were provided
      # @param webhook_auth_header_name [String] The header name which should be sent back with webhook calls
      # @param speed_boost [Boolean] Whether speed boost is enabled
      # @param auto_highlights [Boolean] Whether Key Phrases is enabled, either true or false
      # @param auto_highlights_result [Transcripts::AutoHighlightsResult]
      # @param audio_start_from [Integer] The point in time, in milliseconds, in the file at which the transcription was started
      # @param audio_end_at [Integer] The point in time, in milliseconds, in the file at which the transcription was terminated
      # @param word_boost [Array<String>] The list of custom vocabulary to boost transcription probability for
      # @param boost_param [String] The word boost parameter value
      # @param filter_profanity [Boolean] Whether [Profanity Filtering](https://www.assemblyai.com/docs/models/speech-recognition#profanity-filtering) is enabled, either true or false
      # @param redact_pii [Boolean] Whether [PII Redaction](https://www.assemblyai.com/docs/models/pii-redaction) is enabled, either true or false
      # @param redact_pii_audio [Boolean] Whether a redacted version of the audio file was generated,
      #   either true or false. See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more information.
      # @param redact_pii_audio_quality [REDACT_PII_AUDIO_QUALITY]
      # @param redact_pii_policies [Array<Transcripts::PII_POLICY>] The list of PII Redaction policies that were enabled, if PII Redaction is enabled.
      #   See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more information.
      # @param redact_pii_sub [SUBSTITUTION_POLICY] The replacement logic for detected PII, can be "entity_type" or "hash". See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more details.
      # @param speaker_labels [Boolean] Whether [Speaker diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is enabled, can be true or false
      # @param speakers_expected [Integer] Tell the speaker label model how many speakers it should attempt to identify, up to 10. See [Speaker diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for more details.
      # @param content_safety [Boolean] Whether [Content Moderation](https://www.assemblyai.com/docs/models/content-moderation) is enabled, can be true or false
      # @param content_safety_labels [Transcripts::ContentSafetyLabelsResult]
      # @param iab_categories [Boolean] Whether [Topic Detection](https://www.assemblyai.com/docs/models/topic-detection) is enabled, can be true or false
      # @param iab_categories_result [Transcripts::TopicDetectionModelResult]
      # @param language_detection [Boolean] Whether [Automatic language detection](https://www.assemblyai.com/docs/models/speech-recognition#automatic-language-detection) is enabled, either true or false
      # @param custom_spelling [Array<Transcripts::TranscriptCustomSpelling>] Customize how words are spelled and formatted using to and from values
      # @param auto_chapters [Boolean] Whether [Auto Chapters](https://www.assemblyai.com/docs/models/auto-chapters) is enabled, can be true or false
      # @param chapters [Array<Transcripts::Chapter>] An array of temporally sequential chapters for the audio file
      # @param summarization [Boolean] Whether [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled, either true or false
      # @param summary_type [String] The type of summary generated, if [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled
      # @param summary_model [String] The Summarization model used to generate the summary,
      #   if [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled
      # @param summary [String] The generated summary of the media file, if [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled
      # @param custom_topics [Boolean] Whether custom topics is enabled, either true or false
      # @param topics [Array<String>] The list of custom topics provided if custom topics is enabled
      # @param disfluencies [Boolean] Transcribe Filler Words, like "umm", in your media file; can be true or false
      # @param sentiment_analysis [Boolean] Whether [Sentiment Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis) is enabled, can be true or false
      # @param sentiment_analysis_results [Array<Transcripts::SentimentAnalysisResult>] An array of results for the Sentiment Analysis model, if it is enabled.
      #   See [Sentiment analysis](https://www.assemblyai.com/docs/models/sentiment-analysis) for more information.
      # @param entity_detection [Boolean] Whether [Entity Detection](https://www.assemblyai.com/docs/models/entity-detection) is enabled, can be true or false
      # @param entities [Array<Transcripts::Entity>] An array of results for the Entity Detection model, if it is enabled.
      #   See [Entity detection](https://www.assemblyai.com/docs/models/entity-detection) for more information.
      # @param speech_threshold [Float] Defaults to null. Reject audio files that contain less than this fraction of speech.
      #   Valid values are in the range [0, 1] inclusive.
      # @param throttled [Boolean] True while a request is throttled and false when a request is no longer throttled
      # @param error [String] Error message of why the transcript failed
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::Transcript]
      def initialize(id:, language_model:, acoustic_model:, status:, audio_url:, webhook_auth:, auto_highlights:, redact_pii:, summarization:, speech_model: nil, language_code: nil,
                     text: nil, words: nil, utterances: nil, confidence: nil, audio_duration: nil, punctuate: nil, format_text: nil, dual_channel: nil, webhook_url: nil, webhook_status_code: nil, webhook_auth_header_name: nil, speed_boost: nil, auto_highlights_result: nil, audio_start_from: nil, audio_end_at: nil, word_boost: nil, boost_param: nil, filter_profanity: nil, redact_pii_audio: nil, redact_pii_audio_quality: nil, redact_pii_policies: nil, redact_pii_sub: nil, speaker_labels: nil, speakers_expected: nil, content_safety: nil, content_safety_labels: nil, iab_categories: nil, iab_categories_result: nil, language_detection: nil, custom_spelling: nil, auto_chapters: nil, chapters: nil, summary_type: nil, summary_model: nil, summary: nil, custom_topics: nil, topics: nil, disfluencies: nil, sentiment_analysis: nil, sentiment_analysis_results: nil, entity_detection: nil, entities: nil, speech_threshold: nil, throttled: nil, error: nil, additional_properties: nil)
        # @type [String] The unique identifier of your transcript
        @id = id
        # @type [Transcripts::SPEECH_MODEL]
        @speech_model = speech_model
        # @type [String] The language model that was used for the transcript
        @language_model = language_model
        # @type [String] The acoustic model that was used for the transcript
        @acoustic_model = acoustic_model
        # @type [TRANSCRIPT_STATUS] The status of your transcript. Possible values are queued, processing, completed, or error.
        @status = status
        # @type [TRANSCRIPT_LANGUAGE_CODE] The language of your audio file.
        #   Possible values are found in [Supported Languages](https://www.assemblyai.com/docs/concepts/supported-languages).
        #   The default value is 'en_us'.
        @language_code = language_code
        # @type [String] The URL of the media that was transcribed
        @audio_url = audio_url
        # @type [String] The textual transcript of your media file
        @text = text
        # @type [Array<Transcripts::TranscriptWord>] An array of temporally-sequential word objects, one for each word in the transcript.
        #   See [Speech recognition](https://www.assemblyai.com/docs/models/speech-recognition) for more information.
        @words = words
        # @type [Array<Transcripts::TranscriptUtterance>] When dual_channel or speaker_labels is enabled, a list of turn-by-turn utterance objects.
        #   See [Speaker diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for more information.
        @utterances = utterances
        # @type [Float] The confidence score for the transcript, between 0.0 (low confidence) and 1.0 (high confidence)
        @confidence = confidence
        # @type [Float] The duration of this transcript object's media file, in seconds
        @audio_duration = audio_duration
        # @type [Boolean] Whether Automatic Punctuation is enabled, either true or false
        @punctuate = punctuate
        # @type [Boolean] Whether Text Formatting is enabled, either true or false
        @format_text = format_text
        # @type [Boolean] Whether [Dual channel transcription](https://www.assemblyai.com/docs/models/speech-recognition#dual-channel-transcription) was enabled in the transcription request, either true or false
        @dual_channel = dual_channel
        # @type [String] The URL to which we send webhooks upon trancription completion
        @webhook_url = webhook_url
        # @type [Integer] The status code we received from your server when delivering your webhook, if a webhook URL was provided
        @webhook_status_code = webhook_status_code
        # @type [Boolean] Whether webhook authentication details were provided
        @webhook_auth = webhook_auth
        # @type [String] The header name which should be sent back with webhook calls
        @webhook_auth_header_name = webhook_auth_header_name
        # @type [Boolean] Whether speed boost is enabled
        @speed_boost = speed_boost
        # @type [Boolean] Whether Key Phrases is enabled, either true or false
        @auto_highlights = auto_highlights
        # @type [Transcripts::AutoHighlightsResult]
        @auto_highlights_result = auto_highlights_result
        # @type [Integer] The point in time, in milliseconds, in the file at which the transcription was started
        @audio_start_from = audio_start_from
        # @type [Integer] The point in time, in milliseconds, in the file at which the transcription was terminated
        @audio_end_at = audio_end_at
        # @type [Array<String>] The list of custom vocabulary to boost transcription probability for
        @word_boost = word_boost
        # @type [String] The word boost parameter value
        @boost_param = boost_param
        # @type [Boolean] Whether [Profanity Filtering](https://www.assemblyai.com/docs/models/speech-recognition#profanity-filtering) is enabled, either true or false
        @filter_profanity = filter_profanity
        # @type [Boolean] Whether [PII Redaction](https://www.assemblyai.com/docs/models/pii-redaction) is enabled, either true or false
        @redact_pii = redact_pii
        # @type [Boolean] Whether a redacted version of the audio file was generated,
        #   either true or false. See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more information.
        @redact_pii_audio = redact_pii_audio
        # @type [REDACT_PII_AUDIO_QUALITY]
        @redact_pii_audio_quality = redact_pii_audio_quality
        # @type [Array<Transcripts::PII_POLICY>] The list of PII Redaction policies that were enabled, if PII Redaction is enabled.
        #   See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more information.
        @redact_pii_policies = redact_pii_policies
        # @type [SUBSTITUTION_POLICY] The replacement logic for detected PII, can be "entity_type" or "hash". See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more details.
        @redact_pii_sub = redact_pii_sub
        # @type [Boolean] Whether [Speaker diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is enabled, can be true or false
        @speaker_labels = speaker_labels
        # @type [Integer] Tell the speaker label model how many speakers it should attempt to identify, up to 10. See [Speaker diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for more details.
        @speakers_expected = speakers_expected
        # @type [Boolean] Whether [Content Moderation](https://www.assemblyai.com/docs/models/content-moderation) is enabled, can be true or false
        @content_safety = content_safety
        # @type [Transcripts::ContentSafetyLabelsResult]
        @content_safety_labels = content_safety_labels
        # @type [Boolean] Whether [Topic Detection](https://www.assemblyai.com/docs/models/topic-detection) is enabled, can be true or false
        @iab_categories = iab_categories
        # @type [Transcripts::TopicDetectionModelResult]
        @iab_categories_result = iab_categories_result
        # @type [Boolean] Whether [Automatic language detection](https://www.assemblyai.com/docs/models/speech-recognition#automatic-language-detection) is enabled, either true or false
        @language_detection = language_detection
        # @type [Array<Transcripts::TranscriptCustomSpelling>] Customize how words are spelled and formatted using to and from values
        @custom_spelling = custom_spelling
        # @type [Boolean] Whether [Auto Chapters](https://www.assemblyai.com/docs/models/auto-chapters) is enabled, can be true or false
        @auto_chapters = auto_chapters
        # @type [Array<Transcripts::Chapter>] An array of temporally sequential chapters for the audio file
        @chapters = chapters
        # @type [Boolean] Whether [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled, either true or false
        @summarization = summarization
        # @type [String] The type of summary generated, if [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled
        @summary_type = summary_type
        # @type [String] The Summarization model used to generate the summary,
        #   if [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled
        @summary_model = summary_model
        # @type [String] The generated summary of the media file, if [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled
        @summary = summary
        # @type [Boolean] Whether custom topics is enabled, either true or false
        @custom_topics = custom_topics
        # @type [Array<String>] The list of custom topics provided if custom topics is enabled
        @topics = topics
        # @type [Boolean] Transcribe Filler Words, like "umm", in your media file; can be true or false
        @disfluencies = disfluencies
        # @type [Boolean] Whether [Sentiment Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis) is enabled, can be true or false
        @sentiment_analysis = sentiment_analysis
        # @type [Array<Transcripts::SentimentAnalysisResult>] An array of results for the Sentiment Analysis model, if it is enabled.
        #   See [Sentiment analysis](https://www.assemblyai.com/docs/models/sentiment-analysis) for more information.
        @sentiment_analysis_results = sentiment_analysis_results
        # @type [Boolean] Whether [Entity Detection](https://www.assemblyai.com/docs/models/entity-detection) is enabled, can be true or false
        @entity_detection = entity_detection
        # @type [Array<Transcripts::Entity>] An array of results for the Entity Detection model, if it is enabled.
        #   See [Entity detection](https://www.assemblyai.com/docs/models/entity-detection) for more information.
        @entities = entities
        # @type [Float] Defaults to null. Reject audio files that contain less than this fraction of speech.
        #   Valid values are in the range [0, 1] inclusive.
        @speech_threshold = speech_threshold
        # @type [Boolean] True while a request is throttled and false when a request is no longer throttled
        @throttled = throttled
        # @type [String] Error message of why the transcript failed
        @error = error
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of Transcript
      #
      # @param json_object [JSON]
      # @return [Transcripts::Transcript]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        id = struct.id
        speech_model = struct.speech_model
        language_model = struct.language_model
        acoustic_model = struct.acoustic_model
        status = Transcripts::TRANSCRIPT_STATUS.key(parsed_json["status"]) || parsed_json["status"]
        language_code = Transcripts::TRANSCRIPT_LANGUAGE_CODE.key(parsed_json["language_code"]) || parsed_json["language_code"]
        audio_url = struct.audio_url
        text = struct.text
        words = parsed_json["words"]&.map do |v|
          v = v.to_json
          Transcripts::TranscriptWord.from_json(json_object: v)
        end
        utterances = parsed_json["utterances"]&.map do |v|
          v = v.to_json
          Transcripts::TranscriptUtterance.from_json(json_object: v)
        end
        confidence = struct.confidence
        audio_duration = struct.audio_duration
        punctuate = struct.punctuate
        format_text = struct.format_text
        dual_channel = struct.dual_channel
        webhook_url = struct.webhook_url
        webhook_status_code = struct.webhook_status_code
        webhook_auth = struct.webhook_auth
        webhook_auth_header_name = struct.webhook_auth_header_name
        speed_boost = struct.speed_boost
        auto_highlights = struct.auto_highlights
        if parsed_json["auto_highlights_result"].nil?
          auto_highlights_result = nil
        else
          auto_highlights_result = parsed_json["auto_highlights_result"].to_json
          auto_highlights_result = Transcripts::AutoHighlightsResult.from_json(json_object: auto_highlights_result)
        end
        audio_start_from = struct.audio_start_from
        audio_end_at = struct.audio_end_at
        word_boost = struct.word_boost
        boost_param = struct.boost_param
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
        if parsed_json["content_safety_labels"].nil?
          content_safety_labels = nil
        else
          content_safety_labels = parsed_json["content_safety_labels"].to_json
          content_safety_labels = Transcripts::ContentSafetyLabelsResult.from_json(json_object: content_safety_labels)
        end
        iab_categories = struct.iab_categories
        if parsed_json["iab_categories_result"].nil?
          iab_categories_result = nil
        else
          iab_categories_result = parsed_json["iab_categories_result"].to_json
          iab_categories_result = Transcripts::TopicDetectionModelResult.from_json(json_object: iab_categories_result)
        end
        language_detection = struct.language_detection
        custom_spelling = parsed_json["custom_spelling"]&.map do |v|
          v = v.to_json
          Transcripts::TranscriptCustomSpelling.from_json(json_object: v)
        end
        auto_chapters = struct.auto_chapters
        chapters = parsed_json["chapters"]&.map do |v|
          v = v.to_json
          Transcripts::Chapter.from_json(json_object: v)
        end
        summarization = struct.summarization
        summary_type = struct.summary_type
        summary_model = struct.summary_model
        summary = struct.summary
        custom_topics = struct.custom_topics
        topics = struct.topics
        disfluencies = struct.disfluencies
        sentiment_analysis = struct.sentiment_analysis
        sentiment_analysis_results = parsed_json["sentiment_analysis_results"]&.map do |v|
          v = v.to_json
          Transcripts::SentimentAnalysisResult.from_json(json_object: v)
        end
        entity_detection = struct.entity_detection
        entities = parsed_json["entities"]&.map do |v|
          v = v.to_json
          Transcripts::Entity.from_json(json_object: v)
        end
        speech_threshold = struct.speech_threshold
        throttled = struct.throttled
        error = struct.error
        new(id: id, speech_model: speech_model, language_model: language_model, acoustic_model: acoustic_model,
            status: status, language_code: language_code, audio_url: audio_url, text: text, words: words, utterances: utterances, confidence: confidence, audio_duration: audio_duration, punctuate: punctuate, format_text: format_text, dual_channel: dual_channel, webhook_url: webhook_url, webhook_status_code: webhook_status_code, webhook_auth: webhook_auth, webhook_auth_header_name: webhook_auth_header_name, speed_boost: speed_boost, auto_highlights: auto_highlights, auto_highlights_result: auto_highlights_result, audio_start_from: audio_start_from, audio_end_at: audio_end_at, word_boost: word_boost, boost_param: boost_param, filter_profanity: filter_profanity, redact_pii: redact_pii, redact_pii_audio: redact_pii_audio, redact_pii_audio_quality: redact_pii_audio_quality, redact_pii_policies: redact_pii_policies, redact_pii_sub: redact_pii_sub, speaker_labels: speaker_labels, speakers_expected: speakers_expected, content_safety: content_safety, content_safety_labels: content_safety_labels, iab_categories: iab_categories, iab_categories_result: iab_categories_result, language_detection: language_detection, custom_spelling: custom_spelling, auto_chapters: auto_chapters, chapters: chapters, summarization: summarization, summary_type: summary_type, summary_model: summary_model, summary: summary, custom_topics: custom_topics, topics: topics, disfluencies: disfluencies, sentiment_analysis: sentiment_analysis, sentiment_analysis_results: sentiment_analysis_results, entity_detection: entity_detection, entities: entities, speech_threshold: speech_threshold, throttled: throttled, error: error, additional_properties: struct)
      end

      # Serialize an instance of Transcript to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "id": @id,
          "speech_model": @speech_model,
          "language_model": @language_model,
          "acoustic_model": @acoustic_model,
          "status": Transcripts::TRANSCRIPT_STATUS[@status] || @status,
          "language_code": Transcripts::TRANSCRIPT_LANGUAGE_CODE[@language_code] || @language_code,
          "audio_url": @audio_url,
          "text": @text,
          "words": @words,
          "utterances": @utterances,
          "confidence": @confidence,
          "audio_duration": @audio_duration,
          "punctuate": @punctuate,
          "format_text": @format_text,
          "dual_channel": @dual_channel,
          "webhook_url": @webhook_url,
          "webhook_status_code": @webhook_status_code,
          "webhook_auth": @webhook_auth,
          "webhook_auth_header_name": @webhook_auth_header_name,
          "speed_boost": @speed_boost,
          "auto_highlights": @auto_highlights,
          "auto_highlights_result": @auto_highlights_result,
          "audio_start_from": @audio_start_from,
          "audio_end_at": @audio_end_at,
          "word_boost": @word_boost,
          "boost_param": @boost_param,
          "filter_profanity": @filter_profanity,
          "redact_pii": @redact_pii,
          "redact_pii_audio": @redact_pii_audio,
          "redact_pii_audio_quality": Transcripts::REDACT_PII_AUDIO_QUALITY[@redact_pii_audio_quality] || @redact_pii_audio_quality,
          "redact_pii_policies": @redact_pii_policies,
          "redact_pii_sub": Transcripts::SUBSTITUTION_POLICY[@redact_pii_sub] || @redact_pii_sub,
          "speaker_labels": @speaker_labels,
          "speakers_expected": @speakers_expected,
          "content_safety": @content_safety,
          "content_safety_labels": @content_safety_labels,
          "iab_categories": @iab_categories,
          "iab_categories_result": @iab_categories_result,
          "language_detection": @language_detection,
          "custom_spelling": @custom_spelling,
          "auto_chapters": @auto_chapters,
          "chapters": @chapters,
          "summarization": @summarization,
          "summary_type": @summary_type,
          "summary_model": @summary_model,
          "summary": @summary,
          "custom_topics": @custom_topics,
          "topics": @topics,
          "disfluencies": @disfluencies,
          "sentiment_analysis": @sentiment_analysis,
          "sentiment_analysis_results": @sentiment_analysis_results,
          "entity_detection": @entity_detection,
          "entities": @entities,
          "speech_threshold": @speech_threshold,
          "throttled": @throttled,
          "error": @error
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.id.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.speech_model&.is_a?(String) != false || raise("Passed value for field obj.speech_model is not the expected type, validation failed.")
        obj.language_model.is_a?(String) != false || raise("Passed value for field obj.language_model is not the expected type, validation failed.")
        obj.acoustic_model.is_a?(String) != false || raise("Passed value for field obj.acoustic_model is not the expected type, validation failed.")
        obj.status.is_a?(Transcripts::TRANSCRIPT_STATUS) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
        obj.language_code&.is_a?(Transcripts::TRANSCRIPT_LANGUAGE_CODE) != false || raise("Passed value for field obj.language_code is not the expected type, validation failed.")
        obj.audio_url.is_a?(String) != false || raise("Passed value for field obj.audio_url is not the expected type, validation failed.")
        obj.text&.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.words&.is_a?(Array) != false || raise("Passed value for field obj.words is not the expected type, validation failed.")
        obj.utterances&.is_a?(Array) != false || raise("Passed value for field obj.utterances is not the expected type, validation failed.")
        obj.confidence&.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.audio_duration&.is_a?(Float) != false || raise("Passed value for field obj.audio_duration is not the expected type, validation failed.")
        obj.punctuate&.is_a?(Boolean) != false || raise("Passed value for field obj.punctuate is not the expected type, validation failed.")
        obj.format_text&.is_a?(Boolean) != false || raise("Passed value for field obj.format_text is not the expected type, validation failed.")
        obj.dual_channel&.is_a?(Boolean) != false || raise("Passed value for field obj.dual_channel is not the expected type, validation failed.")
        obj.webhook_url&.is_a?(String) != false || raise("Passed value for field obj.webhook_url is not the expected type, validation failed.")
        obj.webhook_status_code&.is_a?(Integer) != false || raise("Passed value for field obj.webhook_status_code is not the expected type, validation failed.")
        obj.webhook_auth.is_a?(Boolean) != false || raise("Passed value for field obj.webhook_auth is not the expected type, validation failed.")
        obj.webhook_auth_header_name&.is_a?(String) != false || raise("Passed value for field obj.webhook_auth_header_name is not the expected type, validation failed.")
        obj.speed_boost&.is_a?(Boolean) != false || raise("Passed value for field obj.speed_boost is not the expected type, validation failed.")
        obj.auto_highlights.is_a?(Boolean) != false || raise("Passed value for field obj.auto_highlights is not the expected type, validation failed.")
        obj.auto_highlights_result.nil? || Transcripts::AutoHighlightsResult.validate_raw(obj: obj.auto_highlights_result)
        obj.audio_start_from&.is_a?(Integer) != false || raise("Passed value for field obj.audio_start_from is not the expected type, validation failed.")
        obj.audio_end_at&.is_a?(Integer) != false || raise("Passed value for field obj.audio_end_at is not the expected type, validation failed.")
        obj.word_boost&.is_a?(Array) != false || raise("Passed value for field obj.word_boost is not the expected type, validation failed.")
        obj.boost_param&.is_a?(String) != false || raise("Passed value for field obj.boost_param is not the expected type, validation failed.")
        obj.filter_profanity&.is_a?(Boolean) != false || raise("Passed value for field obj.filter_profanity is not the expected type, validation failed.")
        obj.redact_pii.is_a?(Boolean) != false || raise("Passed value for field obj.redact_pii is not the expected type, validation failed.")
        obj.redact_pii_audio&.is_a?(Boolean) != false || raise("Passed value for field obj.redact_pii_audio is not the expected type, validation failed.")
        obj.redact_pii_audio_quality&.is_a?(Transcripts::REDACT_PII_AUDIO_QUALITY) != false || raise("Passed value for field obj.redact_pii_audio_quality is not the expected type, validation failed.")
        obj.redact_pii_policies&.is_a?(Array) != false || raise("Passed value for field obj.redact_pii_policies is not the expected type, validation failed.")
        obj.redact_pii_sub&.is_a?(Transcripts::SUBSTITUTION_POLICY) != false || raise("Passed value for field obj.redact_pii_sub is not the expected type, validation failed.")
        obj.speaker_labels&.is_a?(Boolean) != false || raise("Passed value for field obj.speaker_labels is not the expected type, validation failed.")
        obj.speakers_expected&.is_a?(Integer) != false || raise("Passed value for field obj.speakers_expected is not the expected type, validation failed.")
        obj.content_safety&.is_a?(Boolean) != false || raise("Passed value for field obj.content_safety is not the expected type, validation failed.")
        obj.content_safety_labels.nil? || Transcripts::ContentSafetyLabelsResult.validate_raw(obj: obj.content_safety_labels)
        obj.iab_categories&.is_a?(Boolean) != false || raise("Passed value for field obj.iab_categories is not the expected type, validation failed.")
        obj.iab_categories_result.nil? || Transcripts::TopicDetectionModelResult.validate_raw(obj: obj.iab_categories_result)
        obj.language_detection&.is_a?(Boolean) != false || raise("Passed value for field obj.language_detection is not the expected type, validation failed.")
        obj.custom_spelling&.is_a?(Array) != false || raise("Passed value for field obj.custom_spelling is not the expected type, validation failed.")
        obj.auto_chapters&.is_a?(Boolean) != false || raise("Passed value for field obj.auto_chapters is not the expected type, validation failed.")
        obj.chapters&.is_a?(Array) != false || raise("Passed value for field obj.chapters is not the expected type, validation failed.")
        obj.summarization.is_a?(Boolean) != false || raise("Passed value for field obj.summarization is not the expected type, validation failed.")
        obj.summary_type&.is_a?(String) != false || raise("Passed value for field obj.summary_type is not the expected type, validation failed.")
        obj.summary_model&.is_a?(String) != false || raise("Passed value for field obj.summary_model is not the expected type, validation failed.")
        obj.summary&.is_a?(String) != false || raise("Passed value for field obj.summary is not the expected type, validation failed.")
        obj.custom_topics&.is_a?(Boolean) != false || raise("Passed value for field obj.custom_topics is not the expected type, validation failed.")
        obj.topics&.is_a?(Array) != false || raise("Passed value for field obj.topics is not the expected type, validation failed.")
        obj.disfluencies&.is_a?(Boolean) != false || raise("Passed value for field obj.disfluencies is not the expected type, validation failed.")
        obj.sentiment_analysis&.is_a?(Boolean) != false || raise("Passed value for field obj.sentiment_analysis is not the expected type, validation failed.")
        obj.sentiment_analysis_results&.is_a?(Array) != false || raise("Passed value for field obj.sentiment_analysis_results is not the expected type, validation failed.")
        obj.entity_detection&.is_a?(Boolean) != false || raise("Passed value for field obj.entity_detection is not the expected type, validation failed.")
        obj.entities&.is_a?(Array) != false || raise("Passed value for field obj.entities is not the expected type, validation failed.")
        obj.speech_threshold&.is_a?(Float) != false || raise("Passed value for field obj.speech_threshold is not the expected type, validation failed.")
        obj.throttled&.is_a?(Boolean) != false || raise("Passed value for field obj.throttled is not the expected type, validation failed.")
        obj.error&.is_a?(String) != false || raise("Passed value for field obj.error is not the expected type, validation failed.")
      end
    end
  end
end
