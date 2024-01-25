# frozen_string_literal: true

require_relative "transcript_word"
require "json"

module AssemblyAI
  module Transcripts
    class TranscriptSentence
      attr_reader :text, :start, :end_, :confidence, :words, :speaker, :additional_properties

      # @param text [String]
      # @param start [Integer]
      # @param end_ [Integer]
      # @param confidence [Float]
      # @param words [Array<Transcripts::TranscriptWord>]
      # @param speaker [String] The speaker of the sentence if [Speaker Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is enabled, else null
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::TranscriptSentence]
      def initialize(text:, start:, end_:, confidence:, words:, speaker: nil, additional_properties: nil)
        # @type [String]
        @text = text
        # @type [Integer]
        @start = start
        # @type [Integer]
        @end_ = end_
        # @type [Float]
        @confidence = confidence
        # @type [Array<Transcripts::TranscriptWord>]
        @words = words
        # @type [String] The speaker of the sentence if [Speaker Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is enabled, else null
        @speaker = speaker
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TranscriptSentence
      #
      # @param json_object [JSON]
      # @return [Transcripts::TranscriptSentence]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        text = struct.text
        start = struct.start
        end_ = struct.end
        confidence = struct.confidence
        words = struct.words.map do |v|
          v = v.to_h.to_json
          Transcripts::TranscriptWord.from_json(json_object: v)
        end
        speaker = struct.speaker
        new(text: text, start: start, end_: end_, confidence: confidence, words: words, speaker: speaker,
            additional_properties: struct)
      end

      # Serialize an instance of TranscriptSentence to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "text": @text,
          "start": @start,
          "end": @end_,
          "confidence": @confidence,
          "words": @words,
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
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.words.is_a?(Array) != false || raise("Passed value for field obj.words is not the expected type, validation failed.")
        obj.speaker&.is_a?(String) != false || raise("Passed value for field obj.speaker is not the expected type, validation failed.")
      end
    end
  end
end
