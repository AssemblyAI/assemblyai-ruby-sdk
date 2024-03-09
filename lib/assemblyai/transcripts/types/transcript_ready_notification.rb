# frozen_string_literal: true

require_relative "transcript_ready_status"
require "json"

module AssemblyAI
  class Transcripts
    # The notification when the transcript status is completed or error.
    class TranscriptReadyNotification
      attr_reader :transcript_id, :status, :additional_properties

      # @param transcript_id [String] The ID of the transcript
      # @param status [Transcripts::TranscriptReadyStatus] The status of the transcript. Either completed or error.
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::TranscriptReadyNotification]
      def initialize(transcript_id:, status:, additional_properties: nil)
        # @type [String] The ID of the transcript
        @transcript_id = transcript_id
        # @type [Transcripts::TranscriptReadyStatus] The status of the transcript. Either completed or error.
        @status = status
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TranscriptReadyNotification
      #
      # @param json_object [JSON]
      # @return [Transcripts::TranscriptReadyNotification]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        transcript_id = struct.transcript_id
        status = struct.status
        new(transcript_id: transcript_id, status: status, additional_properties: struct)
      end

      # Serialize an instance of TranscriptReadyNotification to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "transcript_id": @transcript_id, "status": @status }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.transcript_id.is_a?(String) != false || raise("Passed value for field obj.transcript_id is not the expected type, validation failed.")
        obj.status.is_a?(Transcripts::TranscriptReadyStatus) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
      end
    end
  end
end
