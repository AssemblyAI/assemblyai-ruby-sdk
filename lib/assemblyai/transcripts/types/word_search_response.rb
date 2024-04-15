# frozen_string_literal: true

require_relative "word_search_match"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class WordSearchResponse
      # @return [String] The ID of the transcript
      attr_reader :id
      # @return [Integer] The total count of all matched instances. For e.g., word 1 matched 2 times, and
      #  word 2 matched 3 times, `total_count` will equal 5.
      attr_reader :total_count
      # @return [Array<AssemblyAI::Transcripts::WordSearchMatch>] The matches of the search
      attr_reader :matches
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param id [String] The ID of the transcript
      # @param total_count [Integer] The total count of all matched instances. For e.g., word 1 matched 2 times, and
      #  word 2 matched 3 times, `total_count` will equal 5.
      # @param matches [Array<AssemblyAI::Transcripts::WordSearchMatch>] The matches of the search
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::WordSearchResponse]
      def initialize(id:, total_count:, matches:, additional_properties: nil)
        @id = id
        @total_count = total_count
        @matches = matches
        @additional_properties = additional_properties
        @_field_set = { "id": id, "total_count": total_count, "matches": matches }
      end

      # Deserialize a JSON object to an instance of WordSearchResponse
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::WordSearchResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        id = struct["id"]
        total_count = struct["total_count"]
        matches = parsed_json["matches"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::WordSearchMatch.from_json(json_object: v)
        end
        new(
          id: id,
          total_count: total_count,
          matches: matches,
          additional_properties: struct
        )
      end

      # Serialize an instance of WordSearchResponse to a JSON object
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
        obj.id.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.total_count.is_a?(Integer) != false || raise("Passed value for field obj.total_count is not the expected type, validation failed.")
        obj.matches.is_a?(Array) != false || raise("Passed value for field obj.matches is not the expected type, validation failed.")
      end
    end
  end
end
