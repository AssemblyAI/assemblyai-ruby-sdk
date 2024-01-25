# frozen_string_literal: true

require "json"

module AssemblyAI
  module Transcripts
    class PageDetails
      attr_reader :limit, :result_count, :current_url, :prev_url, :next_url, :additional_properties

      # @param limit [Integer]
      # @param result_count [Integer]
      # @param current_url [String]
      # @param prev_url [String]
      # @param next_url [String]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::PageDetails]
      def initialize(limit:, result_count:, current_url:, prev_url:, next_url: nil, additional_properties: nil)
        # @type [Integer]
        @limit = limit
        # @type [Integer]
        @result_count = result_count
        # @type [String]
        @current_url = current_url
        # @type [String]
        @prev_url = prev_url
        # @type [String]
        @next_url = next_url
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of PageDetails
      #
      # @param json_object [JSON]
      # @return [Transcripts::PageDetails]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        limit = struct.limit
        result_count = struct.result_count
        current_url = struct.current_url
        prev_url = struct.prev_url
        next_url = struct.next_url
        new(limit: limit, result_count: result_count, current_url: current_url, prev_url: prev_url, next_url: next_url,
            additional_properties: struct)
      end

      # Serialize an instance of PageDetails to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "limit": @limit,
          "result_count": @result_count,
          "current_url": @current_url,
          "prev_url": @prev_url,
          "next_url": @next_url
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.limit.is_a?(Integer) != false || raise("Passed value for field obj.limit is not the expected type, validation failed.")
        obj.result_count.is_a?(Integer) != false || raise("Passed value for field obj.result_count is not the expected type, validation failed.")
        obj.current_url.is_a?(String) != false || raise("Passed value for field obj.current_url is not the expected type, validation failed.")
        obj.prev_url.is_a?(String) != false || raise("Passed value for field obj.prev_url is not the expected type, validation failed.")
        obj.next_url&.is_a?(String) != false || raise("Passed value for field obj.next_url is not the expected type, validation failed.")
      end
    end
  end
end
