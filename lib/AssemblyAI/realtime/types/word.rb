# frozen_string_literal: true

require "json"

module AssemblyAI
  module Realtime
    class Word
      attr_reader :start, :end_, :confidence, :text, :additional_properties

      # @param start [Integer] Start time of the word in milliseconds
      # @param end_ [Integer] End time of the word in milliseconds
      # @param confidence [Float] Confidence score of the word
      # @param text [String] The word itself
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::Word]
      def initialize(start:, end_:, confidence:, text:, additional_properties: nil)
        # @type [Integer] Start time of the word in milliseconds
        @start = start
        # @type [Integer] End time of the word in milliseconds
        @end_ = end_
        # @type [Float] Confidence score of the word
        @confidence = confidence
        # @type [String] The word itself
        @text = text
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of Word
      #
      # @param json_object [JSON]
      # @return [Realtime::Word]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        start = struct.start
        end_ = struct.end
        confidence = struct.confidence
        text = struct.text
        new(start: start, end_: end_, confidence: confidence, text: text, additional_properties: struct)
      end

      # Serialize an instance of Word to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "start": @start, "end": @end_, "confidence": @confidence, "text": @text }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
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
