# frozen_string_literal: true

require "json"

module AssemblyAI
  class Transcripts
    class SeverityScoreSummary
      attr_reader :low, :medium, :high, :additional_properties

      # @param low [Float]
      # @param medium [Float]
      # @param high [Float]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::SeverityScoreSummary]
      def initialize(low:, medium:, high:, additional_properties: nil)
        # @type [Float]
        @low = low
        # @type [Float]
        @medium = medium
        # @type [Float]
        @high = high
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of SeverityScoreSummary
      #
      # @param json_object [JSON]
      # @return [Transcripts::SeverityScoreSummary]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        low = struct.low
        medium = struct.medium
        high = struct.high
        new(low: low, medium: medium, high: high, additional_properties: struct)
      end

      # Serialize an instance of SeverityScoreSummary to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "low": @low, "medium": @medium, "high": @high }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.low.is_a?(Float) != false || raise("Passed value for field obj.low is not the expected type, validation failed.")
        obj.medium.is_a?(Float) != false || raise("Passed value for field obj.medium is not the expected type, validation failed.")
        obj.high.is_a?(Float) != false || raise("Passed value for field obj.high is not the expected type, validation failed.")
      end
    end
  end
end
