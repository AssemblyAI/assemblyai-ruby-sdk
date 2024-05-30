# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # Details of the transcript page. Transcripts are sorted from newest to oldest.
    #  The previous URL always points to a page with older transcripts.
    class PageDetails
      # @return [Integer] The number of results this page is limited to
      attr_reader :limit
      # @return [Integer] The actual number of results in the page
      attr_reader :result_count
      # @return [String] The URL used to retrieve the current page of transcripts
      attr_reader :current_url
      # @return [String] The URL to the next page of transcripts. The previous URL always points to a
      #  page with older transcripts.
      attr_reader :prev_url
      # @return [String] The URL to the next page of transcripts. The next URL always points to a page
      #  with newer transcripts.
      attr_reader :next_url
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param limit [Integer] The number of results this page is limited to
      # @param result_count [Integer] The actual number of results in the page
      # @param current_url [String] The URL used to retrieve the current page of transcripts
      # @param prev_url [String] The URL to the next page of transcripts. The previous URL always points to a
      #  page with older transcripts.
      # @param next_url [String] The URL to the next page of transcripts. The next URL always points to a page
      #  with newer transcripts.
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::PageDetails]
      def initialize(limit:, result_count:, current_url:, prev_url: OMIT, next_url: OMIT, additional_properties: nil)
        @limit = limit
        @result_count = result_count
        @current_url = current_url
        @prev_url = prev_url if prev_url != OMIT
        @next_url = next_url if next_url != OMIT
        @additional_properties = additional_properties
        @_field_set = {
          "limit": limit,
          "result_count": result_count,
          "current_url": current_url,
          "prev_url": prev_url,
          "next_url": next_url
        }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of PageDetails
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::PageDetails]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        limit = struct["limit"]
        result_count = struct["result_count"]
        current_url = struct["current_url"]
        prev_url = struct["prev_url"]
        next_url = struct["next_url"]
        new(
          limit: limit,
          result_count: result_count,
          current_url: current_url,
          prev_url: prev_url,
          next_url: next_url,
          additional_properties: struct
        )
      end

      # Serialize an instance of PageDetails to a JSON object
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
        obj.limit.is_a?(Integer) != false || raise("Passed value for field obj.limit is not the expected type, validation failed.")
        obj.result_count.is_a?(Integer) != false || raise("Passed value for field obj.result_count is not the expected type, validation failed.")
        obj.current_url.is_a?(String) != false || raise("Passed value for field obj.current_url is not the expected type, validation failed.")
        obj.prev_url&.is_a?(String) != false || raise("Passed value for field obj.prev_url is not the expected type, validation failed.")
        obj.next_url&.is_a?(String) != false || raise("Passed value for field obj.next_url is not the expected type, validation failed.")
      end
    end
  end
end
