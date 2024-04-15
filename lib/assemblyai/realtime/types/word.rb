# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Realtime
    class Word
      # @return [Integer] Start time of the word in milliseconds
      attr_reader :start
      # @return [Integer] End time of the word in milliseconds
      attr_reader :end_
      # @return [Float] Confidence score of the word
      attr_reader :confidence
      # @return [String] The word itself
      attr_reader :text
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param start [Integer] Start time of the word in milliseconds
      # @param end_ [Integer] End time of the word in milliseconds
      # @param confidence [Float] Confidence score of the word
      # @param text [String] The word itself
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Realtime::Word]
      def initialize(start:, end_:, confidence:, text:, additional_properties: nil)
        @start = start
        @end_ = end_
        @confidence = confidence
        @text = text
        @additional_properties = additional_properties
        @_field_set = { "start": start, "end": end_, "confidence": confidence, "text": text }
      end

      # Deserialize a JSON object to an instance of Word
      #
      # @param json_object [String]
      # @return [AssemblyAI::Realtime::Word]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        start = struct["start"]
        end_ = struct["end"]
        confidence = struct["confidence"]
        text = struct["text"]
        new(
          start: start,
          end_: end_,
          confidence: confidence,
          text: text,
          additional_properties: struct
        )
      end

      # Serialize an instance of Word to a JSON object
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
        obj.start.is_a?(Integer) != false || raise("Passed value for field obj.start is not the expected type, validation failed.")
        obj.end_.is_a?(Integer) != false || raise("Passed value for field obj.end_ is not the expected type, validation failed.")
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
      end
    end
  end
end
