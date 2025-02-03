# frozen_string_literal: true

require_relative "transcript_paragraph"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class ParagraphsResponse
      # @return [String] The unique identifier of your transcript
      attr_reader :id
      # @return [Float] The confidence score for the transcript
      attr_reader :confidence
      # @return [Float] The duration of the audio file in seconds
      attr_reader :audio_duration
      # @return [Array<AssemblyAI::Transcripts::TranscriptParagraph>] An array of paragraphs in the transcript
      attr_reader :paragraphs
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param id [String] The unique identifier of your transcript
      # @param confidence [Float] The confidence score for the transcript
      # @param audio_duration [Float] The duration of the audio file in seconds
      # @param paragraphs [Array<AssemblyAI::Transcripts::TranscriptParagraph>] An array of paragraphs in the transcript
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::ParagraphsResponse]
      def initialize(id:, confidence:, audio_duration:, paragraphs:, additional_properties: nil)
        @id = id
        @confidence = confidence
        @audio_duration = audio_duration
        @paragraphs = paragraphs
        @additional_properties = additional_properties
        @_field_set = { "id": id, "confidence": confidence, "audio_duration": audio_duration, "paragraphs": paragraphs }
      end

      # Deserialize a JSON object to an instance of ParagraphsResponse
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::ParagraphsResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        id = parsed_json["id"]
        confidence = parsed_json["confidence"]
        audio_duration = parsed_json["audio_duration"]
        paragraphs = parsed_json["paragraphs"]&.map do |item|
          item = item.to_json
          AssemblyAI::Transcripts::TranscriptParagraph.from_json(json_object: item)
        end
        new(
          id: id,
          confidence: confidence,
          audio_duration: audio_duration,
          paragraphs: paragraphs,
          additional_properties: struct
        )
      end

      # Serialize an instance of ParagraphsResponse to a JSON object
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
        obj.id.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.audio_duration.is_a?(Float) != false || raise("Passed value for field obj.audio_duration is not the expected type, validation failed.")
        obj.paragraphs.is_a?(Array) != false || raise("Passed value for field obj.paragraphs is not the expected type, validation failed.")
      end
    end
  end
end
