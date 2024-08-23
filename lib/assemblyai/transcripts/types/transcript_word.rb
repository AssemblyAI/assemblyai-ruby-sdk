# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class TranscriptWord
      # @return [Float]
      attr_reader :confidence
      # @return [Integer]
      attr_reader :start
      # @return [Integer]
      attr_reader :end_
      # @return [String]
      attr_reader :text
      # @return [String] The speaker of the sentence if [Speaker
      #  Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is
      #  enabled, else null
      attr_reader :speaker
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param confidence [Float]
      # @param start [Integer]
      # @param end_ [Integer]
      # @param text [String]
      # @param speaker [String] The speaker of the sentence if [Speaker
      #  Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is
      #  enabled, else null
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TranscriptWord]
      def initialize(confidence:, start:, end_:, text:, speaker: OMIT, additional_properties: nil)
        @confidence = confidence
        @start = start
        @end_ = end_
        @text = text
        @speaker = speaker if speaker != OMIT
        @additional_properties = additional_properties
        @_field_set = {
          "confidence": confidence,
          "start": start,
          "end": end_,
          "text": text,
          "speaker": speaker
        }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of TranscriptWord
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TranscriptWord]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        confidence = parsed_json["confidence"]
        start = parsed_json["start"]
        end_ = parsed_json["end"]
        text = parsed_json["text"]
        speaker = parsed_json["speaker"]
        new(
          confidence: confidence,
          start: start,
          end_: end_,
          text: text,
          speaker: speaker,
          additional_properties: struct
        )
      end

      # Serialize an instance of TranscriptWord to a JSON object
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
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.start.is_a?(Integer) != false || raise("Passed value for field obj.start is not the expected type, validation failed.")
        obj.end_.is_a?(Integer) != false || raise("Passed value for field obj.end_ is not the expected type, validation failed.")
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.speaker&.is_a?(String) != false || raise("Passed value for field obj.speaker is not the expected type, validation failed.")
      end
    end
  end
end
