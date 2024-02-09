# frozen_string_literal: true

require "json"

module AssemblyAI
  class Transcripts
    class TopicDetectionResultLabelsItem
      attr_reader :relevance, :label, :additional_properties

      # @param relevance [Float] How relevant the detected topic is of a detected topic
      # @param label [String] The IAB taxonomical label for the label of the detected topic, where > denotes supertopic/subtopic relationship
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::TopicDetectionResultLabelsItem]
      def initialize(relevance:, label:, additional_properties: nil)
        # @type [Float] How relevant the detected topic is of a detected topic
        @relevance = relevance
        # @type [String] The IAB taxonomical label for the label of the detected topic, where > denotes supertopic/subtopic relationship
        @label = label
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TopicDetectionResultLabelsItem
      #
      # @param json_object [JSON]
      # @return [Transcripts::TopicDetectionResultLabelsItem]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        relevance = struct.relevance
        label = struct.label
        new(relevance: relevance, label: label, additional_properties: struct)
      end

      # Serialize an instance of TopicDetectionResultLabelsItem to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "relevance": @relevance, "label": @label }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.relevance.is_a?(Float) != false || raise("Passed value for field obj.relevance is not the expected type, validation failed.")
        obj.label.is_a?(String) != false || raise("Passed value for field obj.label is not the expected type, validation failed.")
      end
    end
  end
end
