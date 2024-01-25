# frozen_string_literal: true

require_relative "word"
require "date"
require "json"

module AssemblyAI
  module Realtime
    class PartialTranscript
      attr_reader :message_type, :audio_start, :audio_end, :confidence, :text, :words, :created, :additional_properties

      # @param message_type [String]
      # @param audio_start [Integer] Start time of audio sample relative to session start, in milliseconds
      # @param audio_end [Integer] End time of audio sample relative to session start, in milliseconds
      # @param confidence [Float] The confidence score of the entire transcription, between 0 and 1
      # @param text [String] The partial transcript for your audio
      # @param words [Array<Realtime::Word>] An array of objects, with the information for each word in the transcription text. Includes the start and end time of the word in milliseconds, the confidence score of the word, and the text, which is the word itself.
      # @param created [DateTime] The timestamp for the partial transcript
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::PartialTranscript]
      def initialize(message_type:, audio_start:, audio_end:, confidence:, text:, words:, created:,
                     additional_properties: nil)
        # @type [String]
        @message_type = message_type
        # @type [Integer] Start time of audio sample relative to session start, in milliseconds
        @audio_start = audio_start
        # @type [Integer] End time of audio sample relative to session start, in milliseconds
        @audio_end = audio_end
        # @type [Float] The confidence score of the entire transcription, between 0 and 1
        @confidence = confidence
        # @type [String] The partial transcript for your audio
        @text = text
        # @type [Array<Realtime::Word>] An array of objects, with the information for each word in the transcription text. Includes the start and end time of the word in milliseconds, the confidence score of the word, and the text, which is the word itself.
        @words = words
        # @type [DateTime] The timestamp for the partial transcript
        @created = created
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of PartialTranscript
      #
      # @param json_object [JSON]
      # @return [Realtime::PartialTranscript]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        message_type = struct.message_type
        audio_start = struct.audio_start
        audio_end = struct.audio_end
        confidence = struct.confidence
        text = struct.text
        words = struct.words.map do |v|
          v = v.to_h.to_json
          Realtime::Word.from_json(json_object: v)
        end
        created = DateTime.parse(struct.created)
        new(message_type: message_type, audio_start: audio_start, audio_end: audio_end, confidence: confidence,
            text: text, words: words, created: created, additional_properties: struct)
      end

      # Serialize an instance of PartialTranscript to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "message_type": @message_type,
          "audio_start": @audio_start,
          "audio_end": @audio_end,
          "confidence": @confidence,
          "text": @text,
          "words": @words,
          "created": @created
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.message_type.is_a?(String) != false || raise("Passed value for field obj.message_type is not the expected type, validation failed.")
        obj.audio_start.is_a?(Integer) != false || raise("Passed value for field obj.audio_start is not the expected type, validation failed.")
        obj.audio_end.is_a?(Integer) != false || raise("Passed value for field obj.audio_end is not the expected type, validation failed.")
        obj.confidence.is_a?(Float) != false || raise("Passed value for field obj.confidence is not the expected type, validation failed.")
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.words.is_a?(Array) != false || raise("Passed value for field obj.words is not the expected type, validation failed.")
        obj.created.is_a?(DateTime) != false || raise("Passed value for field obj.created is not the expected type, validation failed.")
      end
    end
  end
end
