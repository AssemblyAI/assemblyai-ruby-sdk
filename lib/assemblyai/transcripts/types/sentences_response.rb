# frozen_string_literal: true

require_relative "transcript_sentence"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class SentencesResponse
      # @return [String] The unique identifier for the transcript
      attr_reader :id
      # @return [Float] The confidence score for the transcript
      attr_reader :confidence
      # @return [Float] The duration of the audio file in seconds
      attr_reader :audio_duration
      # @return [Array<AssemblyAI::Transcripts::TranscriptSentence>] An array of sentences in the transcript
      attr_reader :sentences
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param id [String] The unique identifier for the transcript
      # @param confidence [Float] The confidence score for the transcript
      # @param audio_duration [Float] The duration of the audio file in seconds
      # @param sentences [Array<AssemblyAI::Transcripts::TranscriptSentence>] An array of sentences in the transcript
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::SentencesResponse]
      def initialize(id:, confidence:, audio_duration:, sentences:, additional_properties: nil)
        @id = id
        @confidence = confidence
        @audio_duration = audio_duration
        @sentences = sentences
        @additional_properties = additional_properties
        @_field_set = { "id": id, "confidence": confidence, "audio_duration": audio_duration, "sentences": sentences }
      end

      # Deserialize a JSON object to an instance of SentencesResponse
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::SentencesResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        id = parsed_json["id"]
        confidence = parsed_json["confidence"]
        audio_duration = parsed_json["audio_duration"]
        sentences = parsed_json["sentences"]&.map do |item|
          item = item.to_json
          AssemblyAI::Transcripts::TranscriptSentence.from_json(json_object: item)
        end
        new(
          id: id,
          confidence: confidence,
          audio_duration: audio_duration,
          sentences: sentences,
          additional_properties: struct
        )
      end

      # Serialize an instance of SentencesResponse to a JSON object
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
        obj.sentences.is_a?(Array) != false || raise("Passed value for field obj.sentences is not the expected type, validation failed.")
      end
    end
  end
end
