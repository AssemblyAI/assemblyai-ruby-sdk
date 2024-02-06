# frozen_string_literal: true

require "json"

module AssemblyAI
  class Transcripts
    # Object containing words or phrases to replace, and the word or phrase to replace with
    class TranscriptCustomSpelling
      attr_reader :from, :to, :additional_properties

      # @param from [Array<String>] Words or phrases to replace
      # @param to [String] Word or phrase to replace with
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::TranscriptCustomSpelling]
      def initialize(from:, to:, additional_properties: nil)
        # @type [Array<String>] Words or phrases to replace
        @from = from
        # @type [String] Word or phrase to replace with
        @to = to
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TranscriptCustomSpelling
      #
      # @param json_object [JSON]
      # @return [Transcripts::TranscriptCustomSpelling]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        from = struct.from
        to = struct.to
        new(from: from, to: to, additional_properties: struct)
      end

      # Serialize an instance of TranscriptCustomSpelling to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "from": @from, "to": @to }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
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
