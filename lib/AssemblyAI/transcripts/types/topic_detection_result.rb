# frozen_string_literal: true

require_relative "topic_detection_result_labels_item"
require_relative "timestamp"
require "json"

module AssemblyAI
  module Transcripts
    # The result of the topic detection model
    class TopicDetectionResult
      attr_reader :text, :labels, :timestamp, :additional_properties

      # @param text [String] The text in the transcript in which a detected topic occurs
      # @param labels [Array<Transcripts::TopicDetectionResultLabelsItem>]
      # @param timestamp [Transcripts::Timestamp]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::TopicDetectionResult]
      def initialize(text:, labels: nil, timestamp: nil, additional_properties: nil)
        # @type [String] The text in the transcript in which a detected topic occurs
        @text = text
        # @type [Array<Transcripts::TopicDetectionResultLabelsItem>]
        @labels = labels
        # @type [Transcripts::Timestamp]
        @timestamp = timestamp
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TopicDetectionResult
      #
      # @param json_object [JSON]
      # @return [Transcripts::TopicDetectionResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        text = struct.text
        labels = struct.labels.map do |v|
          v = v.to_h.to_json
          Transcripts::TopicDetectionResultLabelsItem.from_json(json_object: v)
        end
        timestamp = struct.timestamp.to_h.to_json
        timestamp = Transcripts::Timestamp.from_json(json_object: timestamp)
        new(text: text, labels: labels, timestamp: timestamp, additional_properties: struct)
      end

      # Serialize an instance of TopicDetectionResult to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "text": @text, "labels": @labels, "timestamp": @timestamp }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.labels&.is_a?(Array) != false || raise("Passed value for field obj.labels is not the expected type, validation failed.")
        obj.timestamp.nil? || Transcripts::Timestamp.validate_raw(obj: obj.timestamp)
      end
    end
  end
end
