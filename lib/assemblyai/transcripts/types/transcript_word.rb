# frozen_string_literal: true

require "json"

module AssemblyAI
  class Transcripts
    class TranscriptWord
      attr_reader :confidence, :start, :end_, :text, :speaker, :additional_properties

      # @param confidence [Float]
      # @param start [Integer]
      # @param end_ [Integer]
      # @param text [String]
      # @param speaker [String] The speaker of the sentence if [Speaker Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is enabled, else null
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::TranscriptWord]
      def initialize(confidence:, start:, end_:, text:, speaker: nil, additional_properties: nil)
        # @type [Float]
        @confidence = confidence
        # @type [Integer]
        @start = start
        # @type [Integer]
        @end_ = end_
        # @type [String]
        @text = text
        # @type [String] The speaker of the sentence if [Speaker Diarization](https://www.assemblyai.com/docs/models/speaker-diarization) is enabled, else null
        @speaker = speaker
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TranscriptWord
      #
      # @param json_object [JSON]
      # @return [Transcripts::TranscriptWord]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        confidence = struct.confidence
        start = struct.start
        end_ = struct.end
        text = struct.text
        speaker = struct.speaker
        new(confidence: confidence, start: start, end_: end_, text: text, speaker: speaker,
            additional_properties: struct)
      end

      # Serialize an instance of TranscriptWord to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "confidence": @confidence, "start": @start, "end": @end_, "text": @text, "speaker": @speaker }.to_json
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
        obj.speaker&.is_a?(String) != false || raise("Passed value for field obj.speaker is not the expected type, validation failed.")
      end
    end
  end
end
