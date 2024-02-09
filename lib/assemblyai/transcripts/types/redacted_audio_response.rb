# frozen_string_literal: true

require_relative "redacted_audio_status"
require "json"

module AssemblyAI
  class Transcripts
    class RedactedAudioResponse
      attr_reader :status, :redacted_audio_url, :additional_properties

      # @param status [Transcripts::REDACTED_AUDIO_STATUS] The status of the redacted audio
      # @param redacted_audio_url [String] The URL of the redacted audio file
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::RedactedAudioResponse]
      def initialize(status:, redacted_audio_url:, additional_properties: nil)
        # @type [Transcripts::REDACTED_AUDIO_STATUS] The status of the redacted audio
        @status = status
        # @type [String] The URL of the redacted audio file
        @redacted_audio_url = redacted_audio_url
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of RedactedAudioResponse
      #
      # @param json_object [JSON]
      # @return [Transcripts::RedactedAudioResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        status = struct.status
        redacted_audio_url = struct.redacted_audio_url
        new(status: status, redacted_audio_url: redacted_audio_url, additional_properties: struct)
      end

      # Serialize an instance of RedactedAudioResponse to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "status": @status, "redacted_audio_url": @redacted_audio_url }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.status.is_a?(String) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
        obj.redacted_audio_url.is_a?(String) != false || raise("Passed value for field obj.redacted_audio_url is not the expected type, validation failed.")
      end
    end
  end
end
