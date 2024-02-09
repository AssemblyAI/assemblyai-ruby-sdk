# frozen_string_literal: true

require_relative "transcript_word"
require "json"

module AssemblyAI
  class Transcripts
    class TranscriptUtterance
      attr_reader :confidence, :start, :end_, :text, :words, :speaker, :additional_properties

      # @param confidence [Float] The confidence score for the transcript of this utterance
      # @param start [Integer] The starting time, in milliseconds, of the utterance in the audio file
      # @param end_ [Integer] The ending time, in milliseconds, of the utterance in the audio file
      # @param text [String] The text for this utterance
      # @param words [Array<Transcripts::TranscriptWord>] The words in the utterance.
      # @param speaker [String] The speaker of this utterance, where each speaker is assigned a sequential capital letter - e.g. "A" for Speaker A, "B" for Speaker B, etc.
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::TranscriptUtterance]
      def initialize(confidence:, start:, end_:, text:, words:, speaker:, additional_properties: nil)
        # @type [Float] The confidence score for the transcript of this utterance
        @confidence = confidence
        # @type [Integer] The starting time, in milliseconds, of the utterance in the audio file
        @start = start
        # @type [Integer] The ending time, in milliseconds, of the utterance in the audio file
        @end_ = end_
        # @type [String] The text for this utterance
        @text = text
        # @type [Array<Transcripts::TranscriptWord>] The words in the utterance.
        @words = words
        # @type [String] The speaker of this utterance, where each speaker is assigned a sequential capital letter - e.g. "A" for Speaker A, "B" for Speaker B, etc.
        @speaker = speaker
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TranscriptUtterance
      #
      # @param json_object [JSON]
      # @return [Transcripts::TranscriptUtterance]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        confidence = struct.confidence
        start = struct.start
        end_ = struct.end
        text = struct.text
        words = parsed_json["words"]&.map do |v|
          v = v.to_json
          Transcripts::TranscriptWord.from_json(json_object: v)
        end
        speaker = struct.speaker
        new(confidence: confidence, start: start, end_: end_, text: text, words: words, speaker: speaker,
            additional_properties: struct)
      end

      # Serialize an instance of TranscriptUtterance to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "confidence": @confidence,
          "start": @start,
          "end": @end_,
          "text": @text,
          "words": @words,
          "speaker": @speaker
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.start.is_a?(Integer) != false || raise("Passed value for field obj.start is not the expected type, validation failed.")
        obj.end_.is_a?(Integer) != false || raise("Passed value for field obj.end_ is not the expected type, validation failed.")
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.words.is_a?(Array) != false || raise("Passed value for field obj.words is not the expected type, validation failed.")
        obj.speaker.is_a?(String) != false || raise("Passed value for field obj.speaker is not the expected type, validation failed.")
      end
    end
  end
end
