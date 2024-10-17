# frozen_string_literal: true

require_relative "sentiment"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # The result of the Sentiment Analysis model
    class SentimentAnalysisResult
      # @return [String] The transcript of the sentence
      attr_reader :text
      # @return [Integer] The starting time, in milliseconds, of the sentence
      attr_reader :start
      # @return [Integer] The ending time, in milliseconds, of the sentence
      attr_reader :end_
      # @return [AssemblyAI::Transcripts::Sentiment] The detected sentiment for the sentence, one of POSITIVE, NEUTRAL, NEGATIVE
      attr_reader :sentiment
      # @return [Float] The confidence score for the detected sentiment of the sentence, from 0 to 1
      attr_reader :confidence
      # @return [String] The channel of this utterance. The left and right channels are channels 1 and 2.
      #  Additional channels increment the channel number sequentially.
      attr_reader :channel
      # @return [String] The speaker of the sentence if [Speaker
      #  Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is
      #  enabled, else null
      attr_reader :speaker
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param text [String] The transcript of the sentence
      # @param start [Integer] The starting time, in milliseconds, of the sentence
      # @param end_ [Integer] The ending time, in milliseconds, of the sentence
      # @param sentiment [AssemblyAI::Transcripts::Sentiment] The detected sentiment for the sentence, one of POSITIVE, NEUTRAL, NEGATIVE
      # @param confidence [Float] The confidence score for the detected sentiment of the sentence, from 0 to 1
      # @param channel [String] The channel of this utterance. The left and right channels are channels 1 and 2.
      #  Additional channels increment the channel number sequentially.
      # @param speaker [String] The speaker of the sentence if [Speaker
      #  Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is
      #  enabled, else null
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::SentimentAnalysisResult]
      def initialize(text:, start:, end_:, sentiment:, confidence:, channel: OMIT, speaker: OMIT,
                     additional_properties: nil)
        @text = text
        @start = start
        @end_ = end_
        @sentiment = sentiment
        @confidence = confidence
        @channel = channel if channel != OMIT
        @speaker = speaker if speaker != OMIT
        @additional_properties = additional_properties
        @_field_set = {
          "text": text,
          "start": start,
          "end": end_,
          "sentiment": sentiment,
          "confidence": confidence,
          "channel": channel,
          "speaker": speaker
        }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of SentimentAnalysisResult
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::SentimentAnalysisResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        text = struct["text"]
        start = struct["start"]
        end_ = struct["end"]
        sentiment = struct["sentiment"]
        confidence = struct["confidence"]
        channel = struct["channel"]
        speaker = struct["speaker"]
        new(
          text: text,
          start: start,
          end_: end_,
          sentiment: sentiment,
          confidence: confidence,
          channel: channel,
          speaker: speaker,
          additional_properties: struct
        )
      end

      # Serialize an instance of SentimentAnalysisResult to a JSON object
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
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.start.is_a?(Integer) != false || raise("Passed value for field obj.start is not the expected type, validation failed.")
        obj.end_.is_a?(Integer) != false || raise("Passed value for field obj.end_ is not the expected type, validation failed.")
        obj.sentiment.is_a?(AssemblyAI::Transcripts::Sentiment) != false || raise("Passed value for field obj.sentiment is not the expected type, validation failed.")
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.channel&.is_a?(String) != false || raise("Passed value for field obj.channel is not the expected type, validation failed.")
        obj.speaker&.is_a?(String) != false || raise("Passed value for field obj.speaker is not the expected type, validation failed.")
      end
    end
  end
end
