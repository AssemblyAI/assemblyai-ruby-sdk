# frozen_string_literal: true

require_relative "word_search_timestamp"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class WordSearchMatch
      # @return [String] The matched word
      attr_reader :text
      # @return [Integer] The total amount of times the word is in the transcript
      attr_reader :count
      # @return [Array<AssemblyAI::Transcripts::WORD_SEARCH_TIMESTAMP>] An array of timestamps
      attr_reader :timestamps
      # @return [Array<Integer>] An array of all index locations for that word within the `words` array of the
      #  completed transcript
      attr_reader :indexes
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param text [String] The matched word
      # @param count [Integer] The total amount of times the word is in the transcript
      # @param timestamps [Array<AssemblyAI::Transcripts::WORD_SEARCH_TIMESTAMP>] An array of timestamps
      # @param indexes [Array<Integer>] An array of all index locations for that word within the `words` array of the
      #  completed transcript
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::WordSearchMatch]
      def initialize(text:, count:, timestamps:, indexes:, additional_properties: nil)
        @text = text
        @count = count
        @timestamps = timestamps
        @indexes = indexes
        @additional_properties = additional_properties
        @_field_set = { "text": text, "count": count, "timestamps": timestamps, "indexes": indexes }
      end

      # Deserialize a JSON object to an instance of WordSearchMatch
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::WordSearchMatch]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        text = struct["text"]
        count = struct["count"]
        timestamps = struct["timestamps"]
        indexes = struct["indexes"]
        new(
          text: text,
          count: count,
          timestamps: timestamps,
          indexes: indexes,
          additional_properties: struct
        )
      end

      # Serialize an instance of WordSearchMatch to a JSON object
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
        obj.count.is_a?(Integer) != false || raise("Passed value for field obj.count is not the expected type, validation failed.")
        obj.timestamps.is_a?(Array) != false || raise("Passed value for field obj.timestamps is not the expected type, validation failed.")
        obj.indexes.is_a?(Array) != false || raise("Passed value for field obj.indexes is not the expected type, validation failed.")
      end
    end
  end
end
