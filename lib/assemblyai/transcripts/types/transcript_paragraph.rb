# frozen_string_literal: true

require_relative "transcript_word"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class TranscriptParagraph
      # @return [String] The transcript of the paragraph
      attr_reader :text
      # @return [Integer] The starting time, in milliseconds, of the paragraph
      attr_reader :start
      # @return [Integer] The ending time, in milliseconds, of the paragraph
      attr_reader :end_
      # @return [Float] The confidence score for the transcript of this paragraph
      attr_reader :confidence
      # @return [Array<AssemblyAI::Transcripts::TranscriptWord>] An array of words in the paragraph
      attr_reader :words
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param text [String] The transcript of the paragraph
      # @param start [Integer] The starting time, in milliseconds, of the paragraph
      # @param end_ [Integer] The ending time, in milliseconds, of the paragraph
      # @param confidence [Float] The confidence score for the transcript of this paragraph
      # @param words [Array<AssemblyAI::Transcripts::TranscriptWord>] An array of words in the paragraph
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TranscriptParagraph]
      def initialize(text:, start:, end_:, confidence:, words:, additional_properties: nil)
        @text = text
        @start = start
        @end_ = end_
        @confidence = confidence
        @words = words
        @additional_properties = additional_properties
        @_field_set = { "text": text, "start": start, "end": end_, "confidence": confidence, "words": words }
      end

      # Deserialize a JSON object to an instance of TranscriptParagraph
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TranscriptParagraph]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        text = parsed_json["text"]
        start = parsed_json["start"]
        end_ = parsed_json["end"]
        confidence = parsed_json["confidence"]
        words = parsed_json["words"]&.map do |item|
          item = item.to_json
          AssemblyAI::Transcripts::TranscriptWord.from_json(json_object: item)
        end
        new(
          text: text,
          start: start,
          end_: end_,
          confidence: confidence,
          words: words,
          additional_properties: struct
        )
      end

      # Serialize an instance of TranscriptParagraph to a JSON object
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
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.words.is_a?(Array) != false || raise("Passed value for field obj.words is not the expected type, validation failed.")
      end
    end
  end
end
