# frozen_string_literal: true

require_relative "transcript_paragraph"
require "json"

module AssemblyAI
  class Transcripts
    class ParagraphsResponse
      attr_reader :id, :confidence, :audio_duration, :paragraphs, :additional_properties

      # @param id [String]
      # @param confidence [Float]
      # @param audio_duration [Float]
      # @param paragraphs [Array<Transcripts::TranscriptParagraph>]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::ParagraphsResponse]
      def initialize(id:, confidence:, audio_duration:, paragraphs:, additional_properties: nil)
        # @type [String]
        @id = id
        # @type [Float]
        @confidence = confidence
        # @type [Float]
        @audio_duration = audio_duration
        # @type [Array<Transcripts::TranscriptParagraph>]
        @paragraphs = paragraphs
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of ParagraphsResponse
      #
      # @param json_object [JSON]
      # @return [Transcripts::ParagraphsResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        id = struct.id
        confidence = struct.confidence
        audio_duration = struct.audio_duration
        paragraphs = parsed_json["paragraphs"]&.map do |v|
          v = v.to_json
          Transcripts::TranscriptParagraph.from_json(json_object: v)
        end
        new(id: id, confidence: confidence, audio_duration: audio_duration, paragraphs: paragraphs,
            additional_properties: struct)
      end

      # Serialize an instance of ParagraphsResponse to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "id": @id, "confidence": @confidence, "audio_duration": @audio_duration, "paragraphs": @paragraphs }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.id.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.audio_duration.is_a?(Float) != false || raise("Passed value for field obj.audio_duration is not the expected type, validation failed.")
        obj.paragraphs.is_a?(Array) != false || raise("Passed value for field obj.paragraphs is not the expected type, validation failed.")
      end
    end
  end
end
