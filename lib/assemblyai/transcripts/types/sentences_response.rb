# frozen_string_literal: true

require_relative "transcript_sentence"
require "json"

module AssemblyAI
  class Transcripts
    class SentencesResponse
      attr_reader :id, :confidence, :audio_duration, :sentences, :additional_properties

      # @param id [String]
      # @param confidence [Float]
      # @param audio_duration [Float]
      # @param sentences [Array<Transcripts::TranscriptSentence>]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::SentencesResponse]
      def initialize(id:, confidence:, audio_duration:, sentences:, additional_properties: nil)
        # @type [String]
        @id = id
        # @type [Float]
        @confidence = confidence
        # @type [Float]
        @audio_duration = audio_duration
        # @type [Array<Transcripts::TranscriptSentence>]
        @sentences = sentences
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of SentencesResponse
      #
      # @param json_object [JSON]
      # @return [Transcripts::SentencesResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        id = struct.id
        confidence = struct.confidence
        audio_duration = struct.audio_duration
        sentences = parsed_json["sentences"]&.map do |v|
          v = v.to_json
          Transcripts::TranscriptSentence.from_json(json_object: v)
        end
        new(id: id, confidence: confidence, audio_duration: audio_duration, sentences: sentences,
            additional_properties: struct)
      end

      # Serialize an instance of SentencesResponse to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "id": @id, "confidence": @confidence, "audio_duration": @audio_duration, "sentences": @sentences }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
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
