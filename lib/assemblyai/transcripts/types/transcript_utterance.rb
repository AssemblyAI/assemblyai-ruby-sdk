# frozen_string_literal: true

require_relative "transcript_word"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class TranscriptUtterance
      # @return [Float] The confidence score for the transcript of this utterance
      attr_reader :confidence
      # @return [Integer] The starting time, in milliseconds, of the utterance in the audio file
      attr_reader :start
      # @return [Integer] The ending time, in milliseconds, of the utterance in the audio file
      attr_reader :end_
      # @return [String] The text for this utterance
      attr_reader :text
      # @return [Array<AssemblyAI::Transcripts::TranscriptWord>] The words in the utterance.
      attr_reader :words
      # @return [String] The channel of this utterance. The left and right channels are channels 1 and 2.
      #  Additional channels increment the channel number sequentially.
      attr_reader :channel
      # @return [String] The speaker of this utterance, where each speaker is assigned a sequential
      #  capital letter - e.g. "A" for Speaker A, "B" for Speaker B, etc.
      attr_reader :speaker
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param confidence [Float] The confidence score for the transcript of this utterance
      # @param start [Integer] The starting time, in milliseconds, of the utterance in the audio file
      # @param end_ [Integer] The ending time, in milliseconds, of the utterance in the audio file
      # @param text [String] The text for this utterance
      # @param words [Array<AssemblyAI::Transcripts::TranscriptWord>] The words in the utterance.
      # @param channel [String] The channel of this utterance. The left and right channels are channels 1 and 2.
      #  Additional channels increment the channel number sequentially.
      # @param speaker [String] The speaker of this utterance, where each speaker is assigned a sequential
      #  capital letter - e.g. "A" for Speaker A, "B" for Speaker B, etc.
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TranscriptUtterance]
      def initialize(confidence:, start:, end_:, text:, words:, speaker:, channel: OMIT, additional_properties: nil)
        @confidence = confidence
        @start = start
        @end_ = end_
        @text = text
        @words = words
        @channel = channel if channel != OMIT
        @speaker = speaker
        @additional_properties = additional_properties
        @_field_set = {
          "confidence": confidence,
          "start": start,
          "end": end_,
          "text": text,
          "words": words,
          "channel": channel,
          "speaker": speaker
        }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of TranscriptUtterance
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TranscriptUtterance]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        confidence = struct["confidence"]
        start = struct["start"]
        end_ = struct["end"]
        text = struct["text"]
        words = parsed_json["words"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::TranscriptWord.from_json(json_object: v)
        end
        channel = struct["channel"]
        speaker = struct["speaker"]
        new(
          confidence: confidence,
          start: start,
          end_: end_,
          text: text,
          words: words,
          channel: channel,
          speaker: speaker,
          additional_properties: struct
        )
      end

      # Serialize an instance of TranscriptUtterance to a JSON object
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
        obj.words.is_a?(Array) != false || raise("Passed value for field obj.words is not the expected type, validation failed.")
        obj.channel&.is_a?(String) != false || raise("Passed value for field obj.channel is not the expected type, validation failed.")
        obj.speaker.is_a?(String) != false || raise("Passed value for field obj.speaker is not the expected type, validation failed.")
      end
    end
  end
end
