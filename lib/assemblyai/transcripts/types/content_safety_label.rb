# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class ContentSafetyLabel
      # @return [String] The label of the sensitive topic
      attr_reader :label
      # @return [Float] The confidence score for the topic being discussed, from 0 to 1
      attr_reader :confidence
      # @return [Float] How severely the topic is discussed in the section, from 0 to 1
      attr_reader :severity
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param label [String] The label of the sensitive topic
      # @param confidence [Float] The confidence score for the topic being discussed, from 0 to 1
      # @param severity [Float] How severely the topic is discussed in the section, from 0 to 1
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::ContentSafetyLabel]
      def initialize(label:, confidence:, severity:, additional_properties: nil)
        @label = label
        @confidence = confidence
        @severity = severity
        @additional_properties = additional_properties
        @_field_set = { "label": label, "confidence": confidence, "severity": severity }
      end

      # Deserialize a JSON object to an instance of ContentSafetyLabel
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::ContentSafetyLabel]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        label = struct["label"]
        confidence = struct["confidence"]
        severity = struct["severity"]
        new(
          label: label,
          confidence: confidence,
          severity: severity,
          additional_properties: struct
        )
      end

      # Serialize an instance of ContentSafetyLabel to a JSON object
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
        obj.label.is_a?(String) != false || raise("Passed value for field obj.label is not the expected type, validation failed.")
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.severity.is_a?(Float) != false || raise("Passed value for field obj.severity is not the expected type, validation failed.")
      end
    end
  end
end
