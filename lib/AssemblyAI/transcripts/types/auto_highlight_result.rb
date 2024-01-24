# frozen_string_literal: true

require_relative "timestamp"
require "json"

module AssemblyAI
  module Transcripts
    class AutoHighlightResult
      attr_reader :count, :rank, :text, :timestamps, :additional_properties

      # @param count [Integer] The total number of times the key phrase appears in the audio file
      # @param rank [Float] The total relevancy to the overall audio file of this key phrase - a greater number means more relevant
      # @param text [String] The text itself of the key phrase
      # @param timestamps [Array<Transcripts::Timestamp>] The timestamp of the of the key phrase
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::AutoHighlightResult]
      def initialize(count:, rank:, text:, timestamps:, additional_properties: nil)
        # @type [Integer] The total number of times the key phrase appears in the audio file
        @count = count
        # @type [Float] The total relevancy to the overall audio file of this key phrase - a greater number means more relevant
        @rank = rank
        # @type [String] The text itself of the key phrase
        @text = text
        # @type [Array<Transcripts::Timestamp>] The timestamp of the of the key phrase
        @timestamps = timestamps
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of AutoHighlightResult
      #
      # @param json_object [JSON]
      # @return [Transcripts::AutoHighlightResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        count = struct.count
        rank = struct.rank
        text = struct.text
        timestamps = struct.timestamps.map do |v|
          v = v.to_h.to_json
          Transcripts::Timestamp.from_json(json_object: v)
        end
        new(count: count, rank: rank, text: text, timestamps: timestamps, additional_properties: struct)
      end

      # Serialize an instance of AutoHighlightResult to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "count": @count, "rank": @rank, "text": @text, "timestamps": @timestamps }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
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
