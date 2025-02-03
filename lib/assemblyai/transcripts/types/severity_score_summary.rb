# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class SeverityScoreSummary
      # @return [Float]
      attr_reader :low
      # @return [Float]
      attr_reader :medium
      # @return [Float]
      attr_reader :high
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param low [Float]
      # @param medium [Float]
      # @param high [Float]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::SeverityScoreSummary]
      def initialize(low:, medium:, high:, additional_properties: nil)
        @low = low
        @medium = medium
        @high = high
        @additional_properties = additional_properties
        @_field_set = { "low": low, "medium": medium, "high": high }
      end

      # Deserialize a JSON object to an instance of SeverityScoreSummary
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::SeverityScoreSummary]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        low = parsed_json["low"]
        medium = parsed_json["medium"]
        high = parsed_json["high"]
        new(
          low: low,
          medium: medium,
          high: high,
          additional_properties: struct
        )
      end

      # Serialize an instance of SeverityScoreSummary to a JSON object
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
        obj.low.is_a?(Float) != false || raise("Passed value for field obj.low is not the expected type, validation failed.")
        obj.medium.is_a?(Float) != false || raise("Passed value for field obj.medium is not the expected type, validation failed.")
        obj.high.is_a?(Float) != false || raise("Passed value for field obj.high is not the expected type, validation failed.")
      end
    end
  end
end
