# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # Object containing words or phrases to replace, and the word or phrase to replace
    #  with
    class TranscriptCustomSpelling
      # @return [Array<String>] Words or phrases to replace
      attr_reader :from
      # @return [String] Word or phrase to replace with
      attr_reader :to
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param from [Array<String>] Words or phrases to replace
      # @param to [String] Word or phrase to replace with
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TranscriptCustomSpelling]
      def initialize(from:, to:, additional_properties: nil)
        @from = from
        @to = to
        @additional_properties = additional_properties
        @_field_set = { "from": from, "to": to }
      end

      # Deserialize a JSON object to an instance of TranscriptCustomSpelling
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TranscriptCustomSpelling]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        from = parsed_json["from"]
        to = parsed_json["to"]
        new(
          from: from,
          to: to,
          additional_properties: struct
        )
      end

      # Serialize an instance of TranscriptCustomSpelling to a JSON object
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
        obj.from.is_a?(Array) != false || raise("Passed value for field obj.from is not the expected type, validation failed.")
        obj.to.is_a?(String) != false || raise("Passed value for field obj.to is not the expected type, validation failed.")
      end
    end
  end
end
