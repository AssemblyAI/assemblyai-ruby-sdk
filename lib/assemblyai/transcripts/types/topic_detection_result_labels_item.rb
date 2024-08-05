# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class TopicDetectionResultLabelsItem
      # @return [Float] How relevant the detected topic is of a detected topic
      attr_reader :relevance
      # @return [String] The IAB taxonomical label for the label of the detected topic, where > denotes
      #  supertopic/subtopic relationship
      attr_reader :label
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param relevance [Float] How relevant the detected topic is of a detected topic
      # @param label [String] The IAB taxonomical label for the label of the detected topic, where > denotes
      #  supertopic/subtopic relationship
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TopicDetectionResultLabelsItem]
      def initialize(relevance:, label:, additional_properties: nil)
        @relevance = relevance
        @label = label
        @additional_properties = additional_properties
        @_field_set = { "relevance": relevance, "label": label }
      end

      # Deserialize a JSON object to an instance of TopicDetectionResultLabelsItem
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TopicDetectionResultLabelsItem]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        relevance = parsed_json["relevance"]
        label = parsed_json["label"]
        new(
          relevance: relevance,
          label: label,
          additional_properties: struct
        )
      end

      # Serialize an instance of TopicDetectionResultLabelsItem to a JSON object
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
        obj.relevance.is_a?(Float) != false || raise("Passed value for field obj.relevance is not the expected type, validation failed.")
        obj.label.is_a?(String) != false || raise("Passed value for field obj.label is not the expected type, validation failed.")
      end
    end
  end
end
