# frozen_string_literal: true

require "json"

module AssemblyAI
  class Transcripts
    class ContentSafetyLabel
      attr_reader :label, :confidence, :severity, :additional_properties

      # @param label [String] The label of the sensitive topic
      # @param confidence [Float] The confidence score for the topic being discussed, from 0 to 1
      # @param severity [Float] How severely the topic is discussed in the section, from 0 to 1
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::ContentSafetyLabel]
      def initialize(label:, confidence:, severity:, additional_properties: nil)
        # @type [String] The label of the sensitive topic
        @label = label
        # @type [Float] The confidence score for the topic being discussed, from 0 to 1
        @confidence = confidence
        # @type [Float] How severely the topic is discussed in the section, from 0 to 1
        @severity = severity
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of ContentSafetyLabel
      #
      # @param json_object [JSON]
      # @return [Transcripts::ContentSafetyLabel]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        label = struct.label
        confidence = struct.confidence
        severity = struct.severity
        new(label: label, confidence: confidence, severity: severity, additional_properties: struct)
      end

      # Serialize an instance of ContentSafetyLabel to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "label": @label, "confidence": @confidence, "severity": @severity }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
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
