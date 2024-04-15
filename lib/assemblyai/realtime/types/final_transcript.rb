# frozen_string_literal: true

require_relative "word"
require "date"
require "ostruct"
require "json"

module AssemblyAI
  class Realtime
    class FinalTranscript
      # @return [String]
      attr_reader :message_type
      # @return [Boolean] Whether the text is punctuated and cased
      attr_reader :punctuated
      # @return [Boolean] Whether the text is formatted, for example Dollar -> $
      attr_reader :text_formatted
      # @return [Integer] Start time of audio sample relative to session start, in milliseconds
      attr_reader :audio_start
      # @return [Integer] End time of audio sample relative to session start, in milliseconds
      attr_reader :audio_end
      # @return [Float] The confidence score of the entire transcription, between 0 and 1
      attr_reader :confidence
      # @return [String] The partial transcript for your audio
      attr_reader :text
      # @return [Array<AssemblyAI::Realtime::Word>] An array of objects, with the information for each word in the transcription
      #  text.
      #  Includes the start and end time of the word in milliseconds, the confidence
      #  score of the word, and the text, which is the word itself.
      attr_reader :words
      # @return [DateTime] The timestamp for the partial transcript
      attr_reader :created
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param message_type [String]
      # @param punctuated [Boolean] Whether the text is punctuated and cased
      # @param text_formatted [Boolean] Whether the text is formatted, for example Dollar -> $
      # @param audio_start [Integer] Start time of audio sample relative to session start, in milliseconds
      # @param audio_end [Integer] End time of audio sample relative to session start, in milliseconds
      # @param confidence [Float] The confidence score of the entire transcription, between 0 and 1
      # @param text [String] The partial transcript for your audio
      # @param words [Array<AssemblyAI::Realtime::Word>] An array of objects, with the information for each word in the transcription
      #  text.
      #  Includes the start and end time of the word in milliseconds, the confidence
      #  score of the word, and the text, which is the word itself.
      # @param created [DateTime] The timestamp for the partial transcript
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Realtime::FinalTranscript]
      def initialize(message_type:, punctuated:, text_formatted:, audio_start:, audio_end:, confidence:, text:, words:,
                     created:, additional_properties: nil)
        @message_type = message_type
        @punctuated = punctuated
        @text_formatted = text_formatted
        @audio_start = audio_start
        @audio_end = audio_end
        @confidence = confidence
        @text = text
        @words = words
        @created = created
        @additional_properties = additional_properties
        @_field_set = {
          "message_type": message_type,
          "punctuated": punctuated,
          "text_formatted": text_formatted,
          "audio_start": audio_start,
          "audio_end": audio_end,
          "confidence": confidence,
          "text": text,
          "words": words,
          "created": created
        }
      end

      # Deserialize a JSON object to an instance of FinalTranscript
      #
      # @param json_object [String]
      # @return [AssemblyAI::Realtime::FinalTranscript]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        message_type = struct["message_type"]
        punctuated = struct["punctuated"]
        text_formatted = struct["text_formatted"]
        audio_start = struct["audio_start"]
        audio_end = struct["audio_end"]
        confidence = struct["confidence"]
        text = struct["text"]
        words = parsed_json["words"]&.map do |v|
          v = v.to_json
          AssemblyAI::Realtime::Word.from_json(json_object: v)
        end
        created = (DateTime.parse(parsed_json["created"]) unless parsed_json["created"].nil?)
        new(
          message_type: message_type,
          punctuated: punctuated,
          text_formatted: text_formatted,
          audio_start: audio_start,
          audio_end: audio_end,
          confidence: confidence,
          text: text,
          words: words,
          created: created,
          additional_properties: struct
        )
      end

      # Serialize an instance of FinalTranscript to a JSON object
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
        obj.message_type.is_a?(String) != false || raise("Passed value for field obj.message_type is not the expected type, validation failed.")
        obj.punctuated.is_a?(Boolean) != false || raise("Passed value for field obj.punctuated is not the expected type, validation failed.")
        obj.text_formatted.is_a?(Boolean) != false || raise("Passed value for field obj.text_formatted is not the expected type, validation failed.")
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
