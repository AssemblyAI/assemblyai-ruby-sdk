# frozen_string_literal: true

require_relative "transcript_ready_status"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # The notification when the transcript status is completed or error.
    class TranscriptReadyNotification
      # @return [String] The ID of the transcript
      attr_reader :transcript_id
      # @return [AssemblyAI::Transcripts::TranscriptReadyStatus] The status of the transcript. Either completed or error.
      attr_reader :status
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param transcript_id [String] The ID of the transcript
      # @param status [AssemblyAI::Transcripts::TranscriptReadyStatus] The status of the transcript. Either completed or error.
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TranscriptReadyNotification]
      def initialize(transcript_id:, status:, additional_properties: nil)
        @transcript_id = transcript_id
        @status = status
        @additional_properties = additional_properties
        @_field_set = { "transcript_id": transcript_id, "status": status }
      end

      # Deserialize a JSON object to an instance of TranscriptReadyNotification
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TranscriptReadyNotification]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        transcript_id = struct["transcript_id"]
        status = struct["status"]
        new(
          transcript_id: transcript_id,
          status: status,
          additional_properties: struct
        )
      end

      # Serialize an instance of TranscriptReadyNotification to a JSON object
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
        obj.transcript_id.is_a?(String) != false || raise("Passed value for field obj.transcript_id is not the expected type, validation failed.")
        obj.status.is_a?(AssemblyAI::Transcripts::TranscriptReadyStatus) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
      end
    end
  end
end
