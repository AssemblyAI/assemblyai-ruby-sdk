# frozen_string_literal: true

require_relative "timestamp"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class AutoHighlightResult
      # @return [Integer] The total number of times the key phrase appears in the audio file
      attr_reader :count
      # @return [Float] The total relevancy to the overall audio file of this key phrase - a greater
      #  number means more relevant
      attr_reader :rank
      # @return [String] The text itself of the key phrase
      attr_reader :text
      # @return [Array<AssemblyAI::Transcripts::Timestamp>] The timestamp of the of the key phrase
      attr_reader :timestamps
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param count [Integer] The total number of times the key phrase appears in the audio file
      # @param rank [Float] The total relevancy to the overall audio file of this key phrase - a greater
      #  number means more relevant
      # @param text [String] The text itself of the key phrase
      # @param timestamps [Array<AssemblyAI::Transcripts::Timestamp>] The timestamp of the of the key phrase
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::AutoHighlightResult]
      def initialize(count:, rank:, text:, timestamps:, additional_properties: nil)
        @count = count
        @rank = rank
        @text = text
        @timestamps = timestamps
        @additional_properties = additional_properties
        @_field_set = { "count": count, "rank": rank, "text": text, "timestamps": timestamps }
      end

      # Deserialize a JSON object to an instance of AutoHighlightResult
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::AutoHighlightResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        count = parsed_json["count"]
        rank = parsed_json["rank"]
        text = parsed_json["text"]
        timestamps = parsed_json["timestamps"]&.map do |item|
          item = item.to_json
          AssemblyAI::Transcripts::Timestamp.from_json(json_object: item)
        end
        new(
          count: count,
          rank: rank,
          text: text,
          timestamps: timestamps,
          additional_properties: struct
        )
      end

      # Serialize an instance of AutoHighlightResult to a JSON object
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
        obj.count.is_a?(Integer) != false || raise("Passed value for field obj.count is not the expected type, validation failed.")
        obj.rank.is_a?(Float) != false || raise("Passed value for field obj.rank is not the expected type, validation failed.")
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.timestamps.is_a?(Array) != false || raise("Passed value for field obj.timestamps is not the expected type, validation failed.")
      end
    end
  end
end
