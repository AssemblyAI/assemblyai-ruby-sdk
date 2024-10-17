# frozen_string_literal: true

require_relative "topic_detection_result_labels_item"
require_relative "timestamp"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # The result of the topic detection model
    class TopicDetectionResult
      # @return [String] The text in the transcript in which a detected topic occurs
      attr_reader :text
      # @return [Array<AssemblyAI::Transcripts::TopicDetectionResultLabelsItem>] An array of detected topics in the text
      attr_reader :labels
      # @return [AssemblyAI::Transcripts::Timestamp]
      attr_reader :timestamp
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param text [String] The text in the transcript in which a detected topic occurs
      # @param labels [Array<AssemblyAI::Transcripts::TopicDetectionResultLabelsItem>] An array of detected topics in the text
      # @param timestamp [AssemblyAI::Transcripts::Timestamp]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TopicDetectionResult]
      def initialize(text:, labels: OMIT, timestamp: OMIT, additional_properties: nil)
        @text = text
        @labels = labels if labels != OMIT
        @timestamp = timestamp if timestamp != OMIT
        @additional_properties = additional_properties
        @_field_set = { "text": text, "labels": labels, "timestamp": timestamp }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of TopicDetectionResult
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TopicDetectionResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        text = struct["text"]
        labels = parsed_json["labels"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::TopicDetectionResultLabelsItem.from_json(json_object: v)
        end
        if parsed_json["timestamp"].nil?
          timestamp = nil
        else
          timestamp = parsed_json["timestamp"].to_json
          timestamp = AssemblyAI::Transcripts::Timestamp.from_json(json_object: timestamp)
        end
        new(
          text: text,
          labels: labels,
          timestamp: timestamp,
          additional_properties: struct
        )
      end

      # Serialize an instance of TopicDetectionResult to a JSON object
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
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.labels&.is_a?(Array) != false || raise("Passed value for field obj.labels is not the expected type, validation failed.")
        obj.timestamp.nil? || AssemblyAI::Transcripts::Timestamp.validate_raw(obj: obj.timestamp)
      end
    end
  end
end
