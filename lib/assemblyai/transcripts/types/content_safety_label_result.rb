# frozen_string_literal: true

require_relative "content_safety_label"
require_relative "timestamp"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class ContentSafetyLabelResult
      # @return [String] The transcript of the section flagged by the Content Moderation model
      attr_reader :text
      # @return [Array<AssemblyAI::Transcripts::ContentSafetyLabel>] An array of safety labels, one per sensitive topic that was detected in the
      #  section
      attr_reader :labels
      # @return [Integer] The sentence index at which the section begins
      attr_reader :sentences_idx_start
      # @return [Integer] The sentence index at which the section ends
      attr_reader :sentences_idx_end
      # @return [AssemblyAI::Transcripts::Timestamp] Timestamp information for the section
      attr_reader :timestamp
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param text [String] The transcript of the section flagged by the Content Moderation model
      # @param labels [Array<AssemblyAI::Transcripts::ContentSafetyLabel>] An array of safety labels, one per sensitive topic that was detected in the
      #  section
      # @param sentences_idx_start [Integer] The sentence index at which the section begins
      # @param sentences_idx_end [Integer] The sentence index at which the section ends
      # @param timestamp [AssemblyAI::Transcripts::Timestamp] Timestamp information for the section
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::ContentSafetyLabelResult]
      def initialize(text:, labels:, sentences_idx_start:, sentences_idx_end:, timestamp:, additional_properties: nil)
        @text = text
        @labels = labels
        @sentences_idx_start = sentences_idx_start
        @sentences_idx_end = sentences_idx_end
        @timestamp = timestamp
        @additional_properties = additional_properties
        @_field_set = {
          "text": text,
          "labels": labels,
          "sentences_idx_start": sentences_idx_start,
          "sentences_idx_end": sentences_idx_end,
          "timestamp": timestamp
        }
      end

      # Deserialize a JSON object to an instance of ContentSafetyLabelResult
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::ContentSafetyLabelResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        text = parsed_json["text"]
        labels = parsed_json["labels"]&.map do |item|
          item = item.to_json
          AssemblyAI::Transcripts::ContentSafetyLabel.from_json(json_object: item)
        end
        sentences_idx_start = parsed_json["sentences_idx_start"]
        sentences_idx_end = parsed_json["sentences_idx_end"]
        if parsed_json["timestamp"].nil?
          timestamp = nil
        else
          timestamp = parsed_json["timestamp"].to_json
          timestamp = AssemblyAI::Transcripts::Timestamp.from_json(json_object: timestamp)
        end
        new(
          text: text,
          labels: labels,
          sentences_idx_start: sentences_idx_start,
          sentences_idx_end: sentences_idx_end,
          timestamp: timestamp,
          additional_properties: struct
        )
      end

      # Serialize an instance of ContentSafetyLabelResult to a JSON object
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
        obj.labels.is_a?(Array) != false || raise("Passed value for field obj.labels is not the expected type, validation failed.")
        obj.sentences_idx_start.is_a?(Integer) != false || raise("Passed value for field obj.sentences_idx_start is not the expected type, validation failed.")
        obj.sentences_idx_end.is_a?(Integer) != false || raise("Passed value for field obj.sentences_idx_end is not the expected type, validation failed.")
        AssemblyAI::Transcripts::Timestamp.validate_raw(obj: obj.timestamp)
      end
    end
  end
end
