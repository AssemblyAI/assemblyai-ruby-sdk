# frozen_string_literal: true

require_relative "transcript_status"
require_relative "transcript_language_code"
require_relative "speech_model"
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
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # A transcript object
    class Transcript
      # @return [String] The unique identifier of your transcript
      attr_reader :id
      # @return [String] The URL of the media that was transcribed
      attr_reader :audio_url
      # @return [AssemblyAI::Transcripts::TranscriptStatus] The status of your transcript. Possible values are queued, processing,
      #  completed, or error.
      attr_reader :status
      # @return [AssemblyAI::Transcripts::TranscriptLanguageCode] The language of your audio file.
      #  Possible values are found in [Supported
      #  Languages](https://www.assemblyai.com/docs/concepts/supported-languages).
      #  The default value is 'en_us'.
      attr_reader :language_code
      # @return [Boolean] Whether [Automatic language
      #  /www.assemblyai.com/docs/models/speech-recognition#automatic-language-detection)
      #  is enabled, either true or false
      attr_reader :language_detection
      # @return [Float] The confidence threshold for the automatically detected language.
      #  An error will be returned if the language confidence is below this threshold.
      attr_reader :language_confidence_threshold
      # @return [Float] The confidence score for the detected language, between 0.0 (low confidence) and
      #  1.0 (high confidence)
      attr_reader :language_confidence
      # @return [AssemblyAI::Transcripts::SpeechModel]
      attr_reader :speech_model
      # @return [String] The textual transcript of your media file
      attr_reader :text
      # @return [Array<AssemblyAI::Transcripts::TranscriptWord>] An array of temporally-sequential word objects, one for each word in the
      #  transcript.
      #  See [Speech
      #  recognition](https://www.assemblyai.com/docs/models/speech-recognition) for more
      #  information.
      attr_reader :words
      # @return [Array<AssemblyAI::Transcripts::TranscriptUtterance>] When multichannel or speaker_labels is enabled, a list of turn-by-turn utterance
      #  objects.
      #  See [Speaker
      #  diarization](https://www.assemblyai.com/docs/speech-to-text/speaker-diarization)
      #  and [Multichannel
      #  ssemblyai.com/docs/speech-to-text/speech-recognition#multichannel-transcription)
      #  for more information.
      attr_reader :utterances
      # @return [Float] The confidence score for the transcript, between 0.0 (low confidence) and 1.0
      #  (high confidence)
      attr_reader :confidence
      # @return [Integer] The duration of this transcript object's media file, in seconds
      attr_reader :audio_duration
      # @return [Boolean] Whether Automatic Punctuation is enabled, either true or false
      attr_reader :punctuate
      # @return [Boolean] Whether Text Formatting is enabled, either true or false
      attr_reader :format_text
      # @return [Boolean] Transcribe Filler Words, like "umm", in your media file; can be true or false
      attr_reader :disfluencies
      # @return [Boolean] Whether [Multichannel
      #  ://www.assemblyai.com/docs/models/speech-recognition#multichannel-transcription)
      #  was enabled in the transcription request, either true or false
      attr_reader :multichannel
      # @return [Integer] The number of audio channels in the audio file. This is only present when
      #  multichannel is enabled.
      attr_reader :audio_channels
      # @return [Boolean] Whether [Dual channel
      #  ://www.assemblyai.com/docs/models/speech-recognition#dual-channel-transcription)
      #  was enabled in the transcription request, either true or false
      attr_reader :dual_channel
      # @return [String] The URL to which we send webhook requests.
      #  We sends two different types of webhook requests.
      #  One request when a transcript is completed or failed, and one request when the
      #  redacted audio is ready if redact_pii_audio is enabled.
      attr_reader :webhook_url
      # @return [Integer] The status code we received from your server when delivering the transcript
      #  completed or failed webhook request, if a webhook URL was provided
      attr_reader :webhook_status_code
      # @return [Boolean] Whether webhook authentication details were provided
      attr_reader :webhook_auth
      # @return [String] The header name to be sent with the transcript completed or failed webhook
      #  requests
      attr_reader :webhook_auth_header_name
      # @return [Boolean] Whether speed boost is enabled
      attr_reader :speed_boost
      # @return [Boolean] Whether Key Phrases is enabled, either true or false
      attr_reader :auto_highlights
      # @return [AssemblyAI::Transcripts::AutoHighlightsResult]
      attr_reader :auto_highlights_result
      # @return [Integer] The point in time, in milliseconds, in the file at which the transcription was
      #  started
      attr_reader :audio_start_from
      # @return [Integer] The point in time, in milliseconds, in the file at which the transcription was
      #  terminated
      attr_reader :audio_end_at
      # @return [Array<String>] The list of custom vocabulary to boost transcription probability for
      attr_reader :word_boost
      # @return [String] The word boost parameter value
      attr_reader :boost_param
      # @return [Boolean] Whether [Profanity
      #  ](https://www.assemblyai.com/docs/models/speech-recognition#profanity-filtering)
      #  is enabled, either true or false
      attr_reader :filter_profanity
      # @return [Boolean] Whether [PII Redaction](https://www.assemblyai.com/docs/models/pii-redaction) is
      #  enabled, either true or false
      attr_reader :redact_pii
      # @return [Boolean] Whether a redacted version of the audio file was generated,
      #  either true or false. See [PII
      #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
      #  information.
      attr_reader :redact_pii_audio
      # @return [AssemblyAI::Transcripts::RedactPiiAudioQuality]
      attr_reader :redact_pii_audio_quality
      # @return [Array<AssemblyAI::Transcripts::PiiPolicy>] The list of PII Redaction policies that were enabled, if PII Redaction is
      #  enabled.
      #  See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for
      #  more information.
      attr_reader :redact_pii_policies
      # @return [AssemblyAI::Transcripts::SubstitutionPolicy] The replacement logic for detected PII, can be "entity_type" or "hash". See [PII
      #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
      #  details.
      attr_reader :redact_pii_sub
      # @return [Boolean] Whether [Speaker
      #  diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is
      #  enabled, can be true or false
      attr_reader :speaker_labels
      # @return [Integer] Tell the speaker label model how many speakers it should attempt to identify, up
      #  to 10. See [Speaker
      #  diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for
      #  more details.
      attr_reader :speakers_expected
      # @return [Boolean] Whether [Content
      #  Moderation](https://www.assemblyai.com/docs/models/content-moderation) is
      #  enabled, can be true or false
      attr_reader :content_safety
      # @return [AssemblyAI::Transcripts::ContentSafetyLabelsResult]
      attr_reader :content_safety_labels
      # @return [Boolean] Whether [Topic
      #  Detection](https://www.assemblyai.com/docs/models/topic-detection) is enabled,
      #  can be true or false
      attr_reader :iab_categories
      # @return [AssemblyAI::Transcripts::TopicDetectionModelResult]
      attr_reader :iab_categories_result
      # @return [Array<AssemblyAI::Transcripts::TranscriptCustomSpelling>] Customize how words are spelled and formatted using to and from values
      attr_reader :custom_spelling
      # @return [Boolean] Whether [Auto Chapters](https://www.assemblyai.com/docs/models/auto-chapters) is
      #  enabled, can be true or false
      attr_reader :auto_chapters
      # @return [Array<AssemblyAI::Transcripts::Chapter>] An array of temporally sequential chapters for the audio file
      attr_reader :chapters
      # @return [Boolean] Whether [Summarization](https://www.assemblyai.com/docs/models/summarization) is
      #  enabled, either true or false
      attr_reader :summarization
      # @return [String] The type of summary generated, if
      #  [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled
      attr_reader :summary_type
      # @return [String] The Summarization model used to generate the summary,
      #  if [Summarization](https://www.assemblyai.com/docs/models/summarization) is
      #  enabled
      attr_reader :summary_model
      # @return [String] The generated summary of the media file, if
      #  [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled
      attr_reader :summary
      # @return [Boolean] Whether custom topics is enabled, either true or false
      attr_reader :custom_topics
      # @return [Array<String>] The list of custom topics provided if custom topics is enabled
      attr_reader :topics
      # @return [Boolean] Whether [Sentiment
      #  Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis) is enabled,
      #  can be true or false
      attr_reader :sentiment_analysis
      # @return [Array<AssemblyAI::Transcripts::SentimentAnalysisResult>] An array of results for the Sentiment Analysis model, if it is enabled.
      #  See [Sentiment
      #  Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis) for more
      #  information.
      attr_reader :sentiment_analysis_results
      # @return [Boolean] Whether [Entity
      #  Detection](https://www.assemblyai.com/docs/models/entity-detection) is enabled,
      #  can be true or false
      attr_reader :entity_detection
      # @return [Array<AssemblyAI::Transcripts::Entity>] An array of results for the Entity Detection model, if it is enabled.
      #  See [Entity detection](https://www.assemblyai.com/docs/models/entity-detection)
      #  for more information.
      attr_reader :entities
      # @return [Float] Defaults to null. Reject audio files that contain less than this fraction of
      #  speech.
      #  Valid values are in the range [0, 1] inclusive.
      attr_reader :speech_threshold
      # @return [Boolean] True while a request is throttled and false when a request is no longer
      #  throttled
      attr_reader :throttled
      # @return [String] Error message of why the transcript failed
      attr_reader :error
      # @return [String] The language model that was used for the transcript
      attr_reader :language_model
      # @return [String] The acoustic model that was used for the transcript
      attr_reader :acoustic_model
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param id [String] The unique identifier of your transcript
      # @param audio_url [String] The URL of the media that was transcribed
      # @param status [AssemblyAI::Transcripts::TranscriptStatus] The status of your transcript. Possible values are queued, processing,
      #  completed, or error.
      # @param language_code [AssemblyAI::Transcripts::TranscriptLanguageCode] The language of your audio file.
      #  Possible values are found in [Supported
      #  Languages](https://www.assemblyai.com/docs/concepts/supported-languages).
      #  The default value is 'en_us'.
      # @param language_detection [Boolean] Whether [Automatic language
      #  /www.assemblyai.com/docs/models/speech-recognition#automatic-language-detection)
      #  is enabled, either true or false
      # @param language_confidence_threshold [Float] The confidence threshold for the automatically detected language.
      #  An error will be returned if the language confidence is below this threshold.
      # @param language_confidence [Float] The confidence score for the detected language, between 0.0 (low confidence) and
      #  1.0 (high confidence)
      # @param speech_model [AssemblyAI::Transcripts::SpeechModel]
      # @param text [String] The textual transcript of your media file
      # @param words [Array<AssemblyAI::Transcripts::TranscriptWord>] An array of temporally-sequential word objects, one for each word in the
      #  transcript.
      #  See [Speech
      #  recognition](https://www.assemblyai.com/docs/models/speech-recognition) for more
      #  information.
      # @param utterances [Array<AssemblyAI::Transcripts::TranscriptUtterance>] When multichannel or speaker_labels is enabled, a list of turn-by-turn utterance
      #  objects.
      #  See [Speaker
      #  diarization](https://www.assemblyai.com/docs/speech-to-text/speaker-diarization)
      #  and [Multichannel
      #  ssemblyai.com/docs/speech-to-text/speech-recognition#multichannel-transcription)
      #  for more information.
      # @param confidence [Float] The confidence score for the transcript, between 0.0 (low confidence) and 1.0
      #  (high confidence)
      # @param audio_duration [Integer] The duration of this transcript object's media file, in seconds
      # @param punctuate [Boolean] Whether Automatic Punctuation is enabled, either true or false
      # @param format_text [Boolean] Whether Text Formatting is enabled, either true or false
      # @param disfluencies [Boolean] Transcribe Filler Words, like "umm", in your media file; can be true or false
      # @param multichannel [Boolean] Whether [Multichannel
      #  ://www.assemblyai.com/docs/models/speech-recognition#multichannel-transcription)
      #  was enabled in the transcription request, either true or false
      # @param audio_channels [Integer] The number of audio channels in the audio file. This is only present when
      #  multichannel is enabled.
      # @param dual_channel [Boolean] Whether [Dual channel
      #  ://www.assemblyai.com/docs/models/speech-recognition#dual-channel-transcription)
      #  was enabled in the transcription request, either true or false
      # @param webhook_url [String] The URL to which we send webhook requests.
      #  We sends two different types of webhook requests.
      #  One request when a transcript is completed or failed, and one request when the
      #  redacted audio is ready if redact_pii_audio is enabled.
      # @param webhook_status_code [Integer] The status code we received from your server when delivering the transcript
      #  completed or failed webhook request, if a webhook URL was provided
      # @param webhook_auth [Boolean] Whether webhook authentication details were provided
      # @param webhook_auth_header_name [String] The header name to be sent with the transcript completed or failed webhook
      #  requests
      # @param speed_boost [Boolean] Whether speed boost is enabled
      # @param auto_highlights [Boolean] Whether Key Phrases is enabled, either true or false
      # @param auto_highlights_result [AssemblyAI::Transcripts::AutoHighlightsResult]
      # @param audio_start_from [Integer] The point in time, in milliseconds, in the file at which the transcription was
      #  started
      # @param audio_end_at [Integer] The point in time, in milliseconds, in the file at which the transcription was
      #  terminated
      # @param word_boost [Array<String>] The list of custom vocabulary to boost transcription probability for
      # @param boost_param [String] The word boost parameter value
      # @param filter_profanity [Boolean] Whether [Profanity
      #  ](https://www.assemblyai.com/docs/models/speech-recognition#profanity-filtering)
      #  is enabled, either true or false
      # @param redact_pii [Boolean] Whether [PII Redaction](https://www.assemblyai.com/docs/models/pii-redaction) is
      #  enabled, either true or false
      # @param redact_pii_audio [Boolean] Whether a redacted version of the audio file was generated,
      #  either true or false. See [PII
      #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
      #  information.
      # @param redact_pii_audio_quality [AssemblyAI::Transcripts::RedactPiiAudioQuality]
      # @param redact_pii_policies [Array<AssemblyAI::Transcripts::PiiPolicy>] The list of PII Redaction policies that were enabled, if PII Redaction is
      #  enabled.
      #  See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for
      #  more information.
      # @param redact_pii_sub [AssemblyAI::Transcripts::SubstitutionPolicy] The replacement logic for detected PII, can be "entity_type" or "hash". See [PII
      #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
      #  details.
      # @param speaker_labels [Boolean] Whether [Speaker
      #  diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is
      #  enabled, can be true or false
      # @param speakers_expected [Integer] Tell the speaker label model how many speakers it should attempt to identify, up
      #  to 10. See [Speaker
      #  diarization](https://www.assemblyai.com/docs/models/speaker-diarization) for
      #  more details.
      # @param content_safety [Boolean] Whether [Content
      #  Moderation](https://www.assemblyai.com/docs/models/content-moderation) is
      #  enabled, can be true or false
      # @param content_safety_labels [AssemblyAI::Transcripts::ContentSafetyLabelsResult]
      # @param iab_categories [Boolean] Whether [Topic
      #  Detection](https://www.assemblyai.com/docs/models/topic-detection) is enabled,
      #  can be true or false
      # @param iab_categories_result [AssemblyAI::Transcripts::TopicDetectionModelResult]
      # @param custom_spelling [Array<AssemblyAI::Transcripts::TranscriptCustomSpelling>] Customize how words are spelled and formatted using to and from values
      # @param auto_chapters [Boolean] Whether [Auto Chapters](https://www.assemblyai.com/docs/models/auto-chapters) is
      #  enabled, can be true or false
      # @param chapters [Array<AssemblyAI::Transcripts::Chapter>] An array of temporally sequential chapters for the audio file
      # @param summarization [Boolean] Whether [Summarization](https://www.assemblyai.com/docs/models/summarization) is
      #  enabled, either true or false
      # @param summary_type [String] The type of summary generated, if
      #  [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled
      # @param summary_model [String] The Summarization model used to generate the summary,
      #  if [Summarization](https://www.assemblyai.com/docs/models/summarization) is
      #  enabled
      # @param summary [String] The generated summary of the media file, if
      #  [Summarization](https://www.assemblyai.com/docs/models/summarization) is enabled
      # @param custom_topics [Boolean] Whether custom topics is enabled, either true or false
      # @param topics [Array<String>] The list of custom topics provided if custom topics is enabled
      # @param sentiment_analysis [Boolean] Whether [Sentiment
      #  Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis) is enabled,
      #  can be true or false
      # @param sentiment_analysis_results [Array<AssemblyAI::Transcripts::SentimentAnalysisResult>] An array of results for the Sentiment Analysis model, if it is enabled.
      #  See [Sentiment
      #  Analysis](https://www.assemblyai.com/docs/models/sentiment-analysis) for more
      #  information.
      # @param entity_detection [Boolean] Whether [Entity
      #  Detection](https://www.assemblyai.com/docs/models/entity-detection) is enabled,
      #  can be true or false
      # @param entities [Array<AssemblyAI::Transcripts::Entity>] An array of results for the Entity Detection model, if it is enabled.
      #  See [Entity detection](https://www.assemblyai.com/docs/models/entity-detection)
      #  for more information.
      # @param speech_threshold [Float] Defaults to null. Reject audio files that contain less than this fraction of
      #  speech.
      #  Valid values are in the range [0, 1] inclusive.
      # @param throttled [Boolean] True while a request is throttled and false when a request is no longer
      #  throttled
      # @param error [String] Error message of why the transcript failed
      # @param language_model [String] The language model that was used for the transcript
      # @param acoustic_model [String] The acoustic model that was used for the transcript
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::Transcript]
      def initialize(id:, audio_url:, status:, webhook_auth:, auto_highlights:, redact_pii:, summarization:, language_model:, acoustic_model:, language_code: OMIT, language_detection: OMIT,
                     language_confidence_threshold: OMIT, language_confidence: OMIT, speech_model: OMIT, text: OMIT, words: OMIT, utterances: OMIT, confidence: OMIT, audio_duration: OMIT, punctuate: OMIT, format_text: OMIT, disfluencies: OMIT, multichannel: OMIT, audio_channels: OMIT, dual_channel: OMIT, webhook_url: OMIT, webhook_status_code: OMIT, webhook_auth_header_name: OMIT, speed_boost: OMIT, auto_highlights_result: OMIT, audio_start_from: OMIT, audio_end_at: OMIT, word_boost: OMIT, boost_param: OMIT, filter_profanity: OMIT, redact_pii_audio: OMIT, redact_pii_audio_quality: OMIT, redact_pii_policies: OMIT, redact_pii_sub: OMIT, speaker_labels: OMIT, speakers_expected: OMIT, content_safety: OMIT, content_safety_labels: OMIT, iab_categories: OMIT, iab_categories_result: OMIT, custom_spelling: OMIT, auto_chapters: OMIT, chapters: OMIT, summary_type: OMIT, summary_model: OMIT, summary: OMIT, custom_topics: OMIT, topics: OMIT, sentiment_analysis: OMIT, sentiment_analysis_results: OMIT, entity_detection: OMIT, entities: OMIT, speech_threshold: OMIT, throttled: OMIT, error: OMIT, additional_properties: nil)
        @id = id
        @audio_url = audio_url
        @status = status
        @language_code = language_code if language_code != OMIT
        @language_detection = language_detection if language_detection != OMIT
        @language_confidence_threshold = language_confidence_threshold if language_confidence_threshold != OMIT
        @language_confidence = language_confidence if language_confidence != OMIT
        @speech_model = speech_model if speech_model != OMIT
        @text = text if text != OMIT
        @words = words if words != OMIT
        @utterances = utterances if utterances != OMIT
        @confidence = confidence if confidence != OMIT
        @audio_duration = audio_duration if audio_duration != OMIT
        @punctuate = punctuate if punctuate != OMIT
        @format_text = format_text if format_text != OMIT
        @disfluencies = disfluencies if disfluencies != OMIT
        @multichannel = multichannel if multichannel != OMIT
        @audio_channels = audio_channels if audio_channels != OMIT
        @dual_channel = dual_channel if dual_channel != OMIT
        @webhook_url = webhook_url if webhook_url != OMIT
        @webhook_status_code = webhook_status_code if webhook_status_code != OMIT
        @webhook_auth = webhook_auth
        @webhook_auth_header_name = webhook_auth_header_name if webhook_auth_header_name != OMIT
        @speed_boost = speed_boost if speed_boost != OMIT
        @auto_highlights = auto_highlights
        @auto_highlights_result = auto_highlights_result if auto_highlights_result != OMIT
        @audio_start_from = audio_start_from if audio_start_from != OMIT
        @audio_end_at = audio_end_at if audio_end_at != OMIT
        @word_boost = word_boost if word_boost != OMIT
        @boost_param = boost_param if boost_param != OMIT
        @filter_profanity = filter_profanity if filter_profanity != OMIT
        @redact_pii = redact_pii
        @redact_pii_audio = redact_pii_audio if redact_pii_audio != OMIT
        @redact_pii_audio_quality = redact_pii_audio_quality if redact_pii_audio_quality != OMIT
        @redact_pii_policies = redact_pii_policies if redact_pii_policies != OMIT
        @redact_pii_sub = redact_pii_sub if redact_pii_sub != OMIT
        @speaker_labels = speaker_labels if speaker_labels != OMIT
        @speakers_expected = speakers_expected if speakers_expected != OMIT
        @content_safety = content_safety if content_safety != OMIT
        @content_safety_labels = content_safety_labels if content_safety_labels != OMIT
        @iab_categories = iab_categories if iab_categories != OMIT
        @iab_categories_result = iab_categories_result if iab_categories_result != OMIT
        @custom_spelling = custom_spelling if custom_spelling != OMIT
        @auto_chapters = auto_chapters if auto_chapters != OMIT
        @chapters = chapters if chapters != OMIT
        @summarization = summarization
        @summary_type = summary_type if summary_type != OMIT
        @summary_model = summary_model if summary_model != OMIT
        @summary = summary if summary != OMIT
        @custom_topics = custom_topics if custom_topics != OMIT
        @topics = topics if topics != OMIT
        @sentiment_analysis = sentiment_analysis if sentiment_analysis != OMIT
        @sentiment_analysis_results = sentiment_analysis_results if sentiment_analysis_results != OMIT
        @entity_detection = entity_detection if entity_detection != OMIT
        @entities = entities if entities != OMIT
        @speech_threshold = speech_threshold if speech_threshold != OMIT
        @throttled = throttled if throttled != OMIT
        @error = error if error != OMIT
        @language_model = language_model
        @acoustic_model = acoustic_model
        @additional_properties = additional_properties
        @_field_set = {
          "id": id,
          "audio_url": audio_url,
          "status": status,
          "language_code": language_code,
          "language_detection": language_detection,
          "language_confidence_threshold": language_confidence_threshold,
          "language_confidence": language_confidence,
          "speech_model": speech_model,
          "text": text,
          "words": words,
          "utterances": utterances,
          "confidence": confidence,
          "audio_duration": audio_duration,
          "punctuate": punctuate,
          "format_text": format_text,
          "disfluencies": disfluencies,
          "multichannel": multichannel,
          "audio_channels": audio_channels,
          "dual_channel": dual_channel,
          "webhook_url": webhook_url,
          "webhook_status_code": webhook_status_code,
          "webhook_auth": webhook_auth,
          "webhook_auth_header_name": webhook_auth_header_name,
          "speed_boost": speed_boost,
          "auto_highlights": auto_highlights,
          "auto_highlights_result": auto_highlights_result,
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
          "content_safety_labels": content_safety_labels,
          "iab_categories": iab_categories,
          "iab_categories_result": iab_categories_result,
          "custom_spelling": custom_spelling,
          "auto_chapters": auto_chapters,
          "chapters": chapters,
          "summarization": summarization,
          "summary_type": summary_type,
          "summary_model": summary_model,
          "summary": summary,
          "custom_topics": custom_topics,
          "topics": topics,
          "sentiment_analysis": sentiment_analysis,
          "sentiment_analysis_results": sentiment_analysis_results,
          "entity_detection": entity_detection,
          "entities": entities,
          "speech_threshold": speech_threshold,
          "throttled": throttled,
          "error": error,
          "language_model": language_model,
          "acoustic_model": acoustic_model
        }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of Transcript
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::Transcript]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        id = struct["id"]
        audio_url = struct["audio_url"]
        status = struct["status"]
        language_code = struct["language_code"]
        language_detection = struct["language_detection"]
        language_confidence_threshold = struct["language_confidence_threshold"]
        language_confidence = struct["language_confidence"]
        speech_model = struct["speech_model"]
        text = struct["text"]
        words = parsed_json["words"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::TranscriptWord.from_json(json_object: v)
        end
        utterances = parsed_json["utterances"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::TranscriptUtterance.from_json(json_object: v)
        end
        confidence = struct["confidence"]
        audio_duration = struct["audio_duration"]
        punctuate = struct["punctuate"]
        format_text = struct["format_text"]
        disfluencies = struct["disfluencies"]
        multichannel = struct["multichannel"]
        audio_channels = struct["audio_channels"]
        dual_channel = struct["dual_channel"]
        webhook_url = struct["webhook_url"]
        webhook_status_code = struct["webhook_status_code"]
        webhook_auth = struct["webhook_auth"]
        webhook_auth_header_name = struct["webhook_auth_header_name"]
        speed_boost = struct["speed_boost"]
        auto_highlights = struct["auto_highlights"]
        if parsed_json["auto_highlights_result"].nil?
          auto_highlights_result = nil
        else
          auto_highlights_result = parsed_json["auto_highlights_result"].to_json
          auto_highlights_result = AssemblyAI::Transcripts::AutoHighlightsResult.from_json(json_object: auto_highlights_result)
        end
        audio_start_from = struct["audio_start_from"]
        audio_end_at = struct["audio_end_at"]
        word_boost = struct["word_boost"]
        boost_param = struct["boost_param"]
        filter_profanity = struct["filter_profanity"]
        redact_pii = struct["redact_pii"]
        redact_pii_audio = struct["redact_pii_audio"]
        redact_pii_audio_quality = struct["redact_pii_audio_quality"]
        redact_pii_policies = struct["redact_pii_policies"]
        redact_pii_sub = struct["redact_pii_sub"]
        speaker_labels = struct["speaker_labels"]
        speakers_expected = struct["speakers_expected"]
        content_safety = struct["content_safety"]
        if parsed_json["content_safety_labels"].nil?
          content_safety_labels = nil
        else
          content_safety_labels = parsed_json["content_safety_labels"].to_json
          content_safety_labels = AssemblyAI::Transcripts::ContentSafetyLabelsResult.from_json(json_object: content_safety_labels)
        end
        iab_categories = struct["iab_categories"]
        if parsed_json["iab_categories_result"].nil?
          iab_categories_result = nil
        else
          iab_categories_result = parsed_json["iab_categories_result"].to_json
          iab_categories_result = AssemblyAI::Transcripts::TopicDetectionModelResult.from_json(json_object: iab_categories_result)
        end
        custom_spelling = parsed_json["custom_spelling"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::TranscriptCustomSpelling.from_json(json_object: v)
        end
        auto_chapters = struct["auto_chapters"]
        chapters = parsed_json["chapters"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::Chapter.from_json(json_object: v)
        end
        summarization = struct["summarization"]
        summary_type = struct["summary_type"]
        summary_model = struct["summary_model"]
        summary = struct["summary"]
        custom_topics = struct["custom_topics"]
        topics = struct["topics"]
        sentiment_analysis = struct["sentiment_analysis"]
        sentiment_analysis_results = parsed_json["sentiment_analysis_results"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::SentimentAnalysisResult.from_json(json_object: v)
        end
        entity_detection = struct["entity_detection"]
        entities = parsed_json["entities"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::Entity.from_json(json_object: v)
        end
        speech_threshold = struct["speech_threshold"]
        throttled = struct["throttled"]
        error = struct["error"]
        language_model = struct["language_model"]
        acoustic_model = struct["acoustic_model"]
        new(
          id: id,
          audio_url: audio_url,
          status: status,
          language_code: language_code,
          language_detection: language_detection,
          language_confidence_threshold: language_confidence_threshold,
          language_confidence: language_confidence,
          speech_model: speech_model,
          text: text,
          words: words,
          utterances: utterances,
          confidence: confidence,
          audio_duration: audio_duration,
          punctuate: punctuate,
          format_text: format_text,
          disfluencies: disfluencies,
          multichannel: multichannel,
          audio_channels: audio_channels,
          dual_channel: dual_channel,
          webhook_url: webhook_url,
          webhook_status_code: webhook_status_code,
          webhook_auth: webhook_auth,
          webhook_auth_header_name: webhook_auth_header_name,
          speed_boost: speed_boost,
          auto_highlights: auto_highlights,
          auto_highlights_result: auto_highlights_result,
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
          content_safety_labels: content_safety_labels,
          iab_categories: iab_categories,
          iab_categories_result: iab_categories_result,
          custom_spelling: custom_spelling,
          auto_chapters: auto_chapters,
          chapters: chapters,
          summarization: summarization,
          summary_type: summary_type,
          summary_model: summary_model,
          summary: summary,
          custom_topics: custom_topics,
          topics: topics,
          sentiment_analysis: sentiment_analysis,
          sentiment_analysis_results: sentiment_analysis_results,
          entity_detection: entity_detection,
          entities: entities,
          speech_threshold: speech_threshold,
          throttled: throttled,
          error: error,
          language_model: language_model,
          acoustic_model: acoustic_model,
          additional_properties: struct
        )
      end

      # Serialize an instance of Transcript to a JSON object
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
        obj.id.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.audio_url.is_a?(String) != false || raise("Passed value for field obj.audio_url is not the expected type, validation failed.")
        obj.status.is_a?(AssemblyAI::Transcripts::TranscriptStatus) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
        obj.language_code&.is_a?(AssemblyAI::Transcripts::TranscriptLanguageCode) != false || raise("Passed value for field obj.language_code is not the expected type, validation failed.")
        obj.language_detection&.is_a?(Boolean) != false || raise("Passed value for field obj.language_detection is not the expected type, validation failed.")
        obj.language_confidence_threshold&.is_a?(Float) != false || raise("Passed value for field obj.language_confidence_threshold is not the expected type, validation failed.")
        obj.language_confidence&.is_a?(Float) != false || raise("Passed value for field obj.language_confidence is not the expected type, validation failed.")
        obj.speech_model&.is_a?(AssemblyAI::Transcripts::SpeechModel) != false || raise("Passed value for field obj.speech_model is not the expected type, validation failed.")
        obj.text&.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.words&.is_a?(Array) != false || raise("Passed value for field obj.words is not the expected type, validation failed.")
        obj.utterances&.is_a?(Array) != false || raise("Passed value for field obj.utterances is not the expected type, validation failed.")
        obj.confidence&.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.audio_duration&.is_a?(Integer) != false || raise("Passed value for field obj.audio_duration is not the expected type, validation failed.")
        obj.punctuate&.is_a?(Boolean) != false || raise("Passed value for field obj.punctuate is not the expected type, validation failed.")
        obj.format_text&.is_a?(Boolean) != false || raise("Passed value for field obj.format_text is not the expected type, validation failed.")
        obj.disfluencies&.is_a?(Boolean) != false || raise("Passed value for field obj.disfluencies is not the expected type, validation failed.")
        obj.multichannel&.is_a?(Boolean) != false || raise("Passed value for field obj.multichannel is not the expected type, validation failed.")
        obj.audio_channels&.is_a?(Integer) != false || raise("Passed value for field obj.audio_channels is not the expected type, validation failed.")
        obj.dual_channel&.is_a?(Boolean) != false || raise("Passed value for field obj.dual_channel is not the expected type, validation failed.")
        obj.webhook_url&.is_a?(String) != false || raise("Passed value for field obj.webhook_url is not the expected type, validation failed.")
        obj.webhook_status_code&.is_a?(Integer) != false || raise("Passed value for field obj.webhook_status_code is not the expected type, validation failed.")
        obj.webhook_auth.is_a?(Boolean) != false || raise("Passed value for field obj.webhook_auth is not the expected type, validation failed.")
        obj.webhook_auth_header_name&.is_a?(String) != false || raise("Passed value for field obj.webhook_auth_header_name is not the expected type, validation failed.")
        obj.speed_boost&.is_a?(Boolean) != false || raise("Passed value for field obj.speed_boost is not the expected type, validation failed.")
        obj.auto_highlights.is_a?(Boolean) != false || raise("Passed value for field obj.auto_highlights is not the expected type, validation failed.")
        obj.auto_highlights_result.nil? || AssemblyAI::Transcripts::AutoHighlightsResult.validate_raw(obj: obj.auto_highlights_result)
        obj.audio_start_from&.is_a?(Integer) != false || raise("Passed value for field obj.audio_start_from is not the expected type, validation failed.")
        obj.audio_end_at&.is_a?(Integer) != false || raise("Passed value for field obj.audio_end_at is not the expected type, validation failed.")
        obj.word_boost&.is_a?(Array) != false || raise("Passed value for field obj.word_boost is not the expected type, validation failed.")
        obj.boost_param&.is_a?(String) != false || raise("Passed value for field obj.boost_param is not the expected type, validation failed.")
        obj.filter_profanity&.is_a?(Boolean) != false || raise("Passed value for field obj.filter_profanity is not the expected type, validation failed.")
        obj.redact_pii.is_a?(Boolean) != false || raise("Passed value for field obj.redact_pii is not the expected type, validation failed.")
        obj.redact_pii_audio&.is_a?(Boolean) != false || raise("Passed value for field obj.redact_pii_audio is not the expected type, validation failed.")
        obj.redact_pii_audio_quality&.is_a?(AssemblyAI::Transcripts::RedactPiiAudioQuality) != false || raise("Passed value for field obj.redact_pii_audio_quality is not the expected type, validation failed.")
        obj.redact_pii_policies&.is_a?(Array) != false || raise("Passed value for field obj.redact_pii_policies is not the expected type, validation failed.")
        obj.redact_pii_sub&.is_a?(AssemblyAI::Transcripts::SubstitutionPolicy) != false || raise("Passed value for field obj.redact_pii_sub is not the expected type, validation failed.")
        obj.speaker_labels&.is_a?(Boolean) != false || raise("Passed value for field obj.speaker_labels is not the expected type, validation failed.")
        obj.speakers_expected&.is_a?(Integer) != false || raise("Passed value for field obj.speakers_expected is not the expected type, validation failed.")
        obj.content_safety&.is_a?(Boolean) != false || raise("Passed value for field obj.content_safety is not the expected type, validation failed.")
        obj.content_safety_labels.nil? || AssemblyAI::Transcripts::ContentSafetyLabelsResult.validate_raw(obj: obj.content_safety_labels)
        obj.iab_categories&.is_a?(Boolean) != false || raise("Passed value for field obj.iab_categories is not the expected type, validation failed.")
        obj.iab_categories_result.nil? || AssemblyAI::Transcripts::TopicDetectionModelResult.validate_raw(obj: obj.iab_categories_result)
        obj.custom_spelling&.is_a?(Array) != false || raise("Passed value for field obj.custom_spelling is not the expected type, validation failed.")
        obj.auto_chapters&.is_a?(Boolean) != false || raise("Passed value for field obj.auto_chapters is not the expected type, validation failed.")
        obj.chapters&.is_a?(Array) != false || raise("Passed value for field obj.chapters is not the expected type, validation failed.")
        obj.summarization.is_a?(Boolean) != false || raise("Passed value for field obj.summarization is not the expected type, validation failed.")
        obj.summary_type&.is_a?(String) != false || raise("Passed value for field obj.summary_type is not the expected type, validation failed.")
        obj.summary_model&.is_a?(String) != false || raise("Passed value for field obj.summary_model is not the expected type, validation failed.")
        obj.summary&.is_a?(String) != false || raise("Passed value for field obj.summary is not the expected type, validation failed.")
        obj.custom_topics&.is_a?(Boolean) != false || raise("Passed value for field obj.custom_topics is not the expected type, validation failed.")
        obj.topics&.is_a?(Array) != false || raise("Passed value for field obj.topics is not the expected type, validation failed.")
        obj.sentiment_analysis&.is_a?(Boolean) != false || raise("Passed value for field obj.sentiment_analysis is not the expected type, validation failed.")
        obj.sentiment_analysis_results&.is_a?(Array) != false || raise("Passed value for field obj.sentiment_analysis_results is not the expected type, validation failed.")
        obj.entity_detection&.is_a?(Boolean) != false || raise("Passed value for field obj.entity_detection is not the expected type, validation failed.")
        obj.entities&.is_a?(Array) != false || raise("Passed value for field obj.entities is not the expected type, validation failed.")
        obj.speech_threshold&.is_a?(Float) != false || raise("Passed value for field obj.speech_threshold is not the expected type, validation failed.")
        obj.throttled&.is_a?(Boolean) != false || raise("Passed value for field obj.throttled is not the expected type, validation failed.")
        obj.error&.is_a?(String) != false || raise("Passed value for field obj.error is not the expected type, validation failed.")
        obj.language_model.is_a?(String) != false || raise("Passed value for field obj.language_model is not the expected type, validation failed.")
        obj.acoustic_model.is_a?(String) != false || raise("Passed value for field obj.acoustic_model is not the expected type, validation failed.")
      end
    end
  end
end
