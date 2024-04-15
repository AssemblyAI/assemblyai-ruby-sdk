# frozen_string_literal: true

require_relative "transcript_word"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class TranscriptSentence
      # @return [String]
      attr_reader :text
      # @return [Integer]
      attr_reader :start
      # @return [Integer]
      attr_reader :end_
      # @return [Float]
      attr_reader :confidence
      # @return [Array<AssemblyAI::Transcripts::TranscriptWord>]
      attr_reader :words
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

      # @param text [String]
      # @param start [Integer]
      # @param end_ [Integer]
      # @param confidence [Float]
      # @param words [Array<AssemblyAI::Transcripts::TranscriptWord>]
      # @param speaker [String] The speaker of the sentence if [Speaker
      #  Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is
      #  enabled, else null
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TranscriptSentence]
      def initialize(text:, start:, end_:, confidence:, words:, speaker: OMIT, additional_properties: nil)
        @text = text
        @start = start
        @end_ = end_
        @confidence = confidence
        @words = words
        @speaker = speaker if speaker != OMIT
        @additional_properties = additional_properties
        @_field_set = {
          "text": text,
          "start": start,
          "end": end_,
          "confidence": confidence,
          "words": words,
          "speaker": speaker
        }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of TranscriptSentence
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TranscriptSentence]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        text = struct["text"]
        start = struct["start"]
        end_ = struct["end"]
        confidence = struct["confidence"]
        words = parsed_json["words"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::TranscriptWord.from_json(json_object: v)
        end
        speaker = struct["speaker"]
        new(
          text: text,
          start: start,
          end_: end_,
          confidence: confidence,
          words: words,
          speaker: speaker,
          additional_properties: struct
        )
      end

      # Serialize an instance of TranscriptSentence to a JSON object
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
        obj.start.is_a?(Integer) != false || raise("Passed value for field obj.start is not the expected type, validation failed.")
        obj.end_.is_a?(Integer) != false || raise("Passed value for field obj.end_ is not the expected type, validation failed.")
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.words.is_a?(Array) != false || raise("Passed value for field obj.words is not the expected type, validation failed.")
        obj.speaker&.is_a?(String) != false || raise("Passed value for field obj.speaker is not the expected type, validation failed.")
      end
    end
  end
end
