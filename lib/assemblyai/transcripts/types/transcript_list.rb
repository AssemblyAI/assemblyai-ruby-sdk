# frozen_string_literal: true

require_relative "page_details"
require_relative "transcript_list_item"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # A list of transcripts. Transcripts are sorted from newest to oldest. The
    #  previous URL always points to a page with older transcripts.
    class TranscriptList
      # @return [AssemblyAI::Transcripts::PageDetails]
      attr_reader :page_details
      # @return [Array<AssemblyAI::Transcripts::TranscriptListItem>]
      attr_reader :transcripts
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param page_details [AssemblyAI::Transcripts::PageDetails]
      # @param transcripts [Array<AssemblyAI::Transcripts::TranscriptListItem>]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TranscriptList]
      def initialize(page_details:, transcripts:, additional_properties: nil)
        @page_details = page_details
        @transcripts = transcripts
        @additional_properties = additional_properties
        @_field_set = { "page_details": page_details, "transcripts": transcripts }
      end

      # Deserialize a JSON object to an instance of TranscriptList
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TranscriptList]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        if parsed_json["page_details"].nil?
          page_details = nil
        else
          page_details = parsed_json["page_details"].to_json
          page_details = AssemblyAI::Transcripts::PageDetails.from_json(json_object: page_details)
        end
        transcripts = parsed_json["transcripts"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::TranscriptListItem.from_json(json_object: v)
        end
        new(
          page_details: page_details,
          transcripts: transcripts,
          additional_properties: struct
        )
      end

      # Serialize an instance of TranscriptList to a JSON object
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
        AssemblyAI::Transcripts::PageDetails.validate_raw(obj: obj.page_details)
        obj.transcripts.is_a?(Array) != false || raise("Passed value for field obj.transcripts is not the expected type, validation failed.")
      end
    end
  end
end
