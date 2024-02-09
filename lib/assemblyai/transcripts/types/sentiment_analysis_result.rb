# frozen_string_literal: true

require_relative "sentiment"
require "json"

module AssemblyAI
  class Transcripts
    # The result of the sentiment analysis model
    class SentimentAnalysisResult
      attr_reader :text, :start, :end_, :sentiment, :confidence, :speaker, :additional_properties

      # @param text [String] The transcript of the sentence
      # @param start [Integer] The starting time, in milliseconds, of the sentence
      # @param end_ [Integer] The ending time, in milliseconds, of the sentence
      # @param sentiment [SENTIMENT] The detected sentiment for the sentence, one of POSITIVE, NEUTRAL, NEGATIVE
      # @param confidence [Float] The confidence score for the detected sentiment of the sentence, from 0 to 1
      # @param speaker [String] The speaker of the sentence if [Speaker Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is enabled, else null
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::SentimentAnalysisResult]
      def initialize(text:, start:, end_:, sentiment:, confidence:, speaker: nil, additional_properties: nil)
        # @type [String] The transcript of the sentence
        @text = text
        # @type [Integer] The starting time, in milliseconds, of the sentence
        @start = start
        # @type [Integer] The ending time, in milliseconds, of the sentence
        @end_ = end_
        # @type [SENTIMENT] The detected sentiment for the sentence, one of POSITIVE, NEUTRAL, NEGATIVE
        @sentiment = sentiment
        # @type [Float] The confidence score for the detected sentiment of the sentence, from 0 to 1
        @confidence = confidence
        # @type [String] The speaker of the sentence if [Speaker Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is enabled, else null
        @speaker = speaker
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of SentimentAnalysisResult
      #
      # @param json_object [JSON]
      # @return [Transcripts::SentimentAnalysisResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        text = struct.text
        start = struct.start
        end_ = struct.end
        sentiment = Transcripts::SENTIMENT.key(parsed_json["sentiment"]) || parsed_json["sentiment"]
        confidence = struct.confidence
        speaker = struct.speaker
        new(text: text, start: start, end_: end_, sentiment: sentiment, confidence: confidence, speaker: speaker,
            additional_properties: struct)
      end

      # Serialize an instance of SentimentAnalysisResult to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "text": @text,
          "start": @start,
          "end": @end_,
          "sentiment": Transcripts::SENTIMENT[@sentiment] || @sentiment,
          "confidence": @confidence,
          "speaker": @speaker
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.start.is_a?(Integer) != false || raise("Passed value for field obj.start is not the expected type, validation failed.")
        obj.end_.is_a?(Integer) != false || raise("Passed value for field obj.end_ is not the expected type, validation failed.")
        obj.sentiment.is_a?(Transcripts::SENTIMENT) != false || raise("Passed value for field obj.sentiment is not the expected type, validation failed.")
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.speaker&.is_a?(String) != false || raise("Passed value for field obj.speaker is not the expected type, validation failed.")
      end
    end
  end
end
