# frozen_string_literal: true

require_relative "content_safety_label"
require_relative "timestamp"
require "json"

module AssemblyAI
  module Transcripts
    class ContentSafetyLabelResult
      attr_reader :text, :labels, :sentences_idx_start, :sentences_idx_end, :timestamp, :additional_properties

      # @param text [String] The transcript of the section flagged by the Content Moderation model
      # @param labels [Array<Transcripts::ContentSafetyLabel>] An array of safety labels, one per sensitive topic that was detected in the section
      # @param sentences_idx_start [Integer] The sentence index at which the section begins
      # @param sentences_idx_end [Integer] The sentence index at which the section ends
      # @param timestamp [Transcripts::Timestamp] Timestamp information for the section
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::ContentSafetyLabelResult]
      def initialize(text:, labels:, sentences_idx_start:, sentences_idx_end:, timestamp:, additional_properties: nil)
        # @type [String] The transcript of the section flagged by the Content Moderation model
        @text = text
        # @type [Array<Transcripts::ContentSafetyLabel>] An array of safety labels, one per sensitive topic that was detected in the section
        @labels = labels
        # @type [Integer] The sentence index at which the section begins
        @sentences_idx_start = sentences_idx_start
        # @type [Integer] The sentence index at which the section ends
        @sentences_idx_end = sentences_idx_end
        # @type [Transcripts::Timestamp] Timestamp information for the section
        @timestamp = timestamp
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of ContentSafetyLabelResult
      #
      # @param json_object [JSON]
      # @return [Transcripts::ContentSafetyLabelResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        text = struct.text
        labels = struct.labels.map do |v|
          v = v.to_h.to_json
          Transcripts::ContentSafetyLabel.from_json(json_object: v)
        end
        sentences_idx_start = struct.sentences_idx_start
        sentences_idx_end = struct.sentences_idx_end
        timestamp = struct.timestamp.to_h.to_json
        timestamp = Transcripts::Timestamp.from_json(json_object: timestamp)
        new(text: text, labels: labels, sentences_idx_start: sentences_idx_start, sentences_idx_end: sentences_idx_end,
            timestamp: timestamp, additional_properties: struct)
      end

      # Serialize an instance of ContentSafetyLabelResult to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "text": @text,
          "labels": @labels,
          "sentences_idx_start": @sentences_idx_start,
          "sentences_idx_end": @sentences_idx_end,
          "timestamp": @timestamp
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.labels.is_a?(Array) != false || raise("Passed value for field obj.labels is not the expected type, validation failed.")
        obj.sentences_idx_start.is_a?(Integer) != false || raise("Passed value for field obj.sentences_idx_start is not the expected type, validation failed.")
        obj.sentences_idx_end.is_a?(Integer) != false || raise("Passed value for field obj.sentences_idx_end is not the expected type, validation failed.")
        Transcripts::Timestamp.validate_raw(obj: obj.timestamp)
      end
    end
  end
end
