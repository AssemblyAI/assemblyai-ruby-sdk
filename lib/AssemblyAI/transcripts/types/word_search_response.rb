# frozen_string_literal: true

require_relative "word_search_match"
require "json"

module AssemblyAI
  module Transcripts
    class WordSearchResponse
      attr_reader :id, :total_count, :matches, :additional_properties

      # @param id [String] The ID of the transcript
      # @param total_count [Integer] The total count of all matched instances. For e.g., word 1 matched 2 times, and word 2 matched 3 times, `total_count` will equal 5.
      # @param matches [Array<Transcripts::WordSearchMatch>] The matches of the search
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::WordSearchResponse]
      def initialize(id:, total_count:, matches:, additional_properties: nil)
        # @type [String] The ID of the transcript
        @id = id
        # @type [Integer] The total count of all matched instances. For e.g., word 1 matched 2 times, and word 2 matched 3 times, `total_count` will equal 5.
        @total_count = total_count
        # @type [Array<Transcripts::WordSearchMatch>] The matches of the search
        @matches = matches
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of WordSearchResponse
      #
      # @param json_object [JSON]
      # @return [Transcripts::WordSearchResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        id = struct.id
        total_count = struct.total_count
        matches = struct.matches.map do |v|
          v = v.to_h.to_json
          Transcripts::WordSearchMatch.from_json(json_object: v)
        end
        new(id: id, total_count: total_count, matches: matches, additional_properties: struct)
      end

      # Serialize an instance of WordSearchResponse to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "id": @id, "total_count": @total_count, "matches": @matches }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.id.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.total_count.is_a?(Integer) != false || raise("Passed value for field obj.total_count is not the expected type, validation failed.")
        obj.matches.is_a?(Array) != false || raise("Passed value for field obj.matches is not the expected type, validation failed.")
      end
    end
  end
end
