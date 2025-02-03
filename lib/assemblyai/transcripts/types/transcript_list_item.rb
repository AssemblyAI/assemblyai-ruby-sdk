# frozen_string_literal: true

require_relative "transcript_status"
require "date"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    class TranscriptListItem
      # @return [String] The unique identifier for the transcript
      attr_reader :id
      # @return [String] The URL to retrieve the transcript
      attr_reader :resource_url
      # @return [AssemblyAI::Transcripts::TranscriptStatus] The status of the transcript
      attr_reader :status
      # @return [DateTime] The date and time the transcript was created
      attr_reader :created
      # @return [DateTime] The date and time the transcript was completed
      attr_reader :completed
      # @return [String] The URL to the audio file
      attr_reader :audio_url
      # @return [String] Error message of why the transcript failed
      attr_reader :error
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param id [String] The unique identifier for the transcript
      # @param resource_url [String] The URL to retrieve the transcript
      # @param status [AssemblyAI::Transcripts::TranscriptStatus] The status of the transcript
      # @param created [DateTime] The date and time the transcript was created
      # @param completed [DateTime] The date and time the transcript was completed
      # @param audio_url [String] The URL to the audio file
      # @param error [String] Error message of why the transcript failed
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::TranscriptListItem]
      def initialize(id:, resource_url:, status:, created:, audio_url:, completed: OMIT, error: OMIT,
                     additional_properties: nil)
        @id = id
        @resource_url = resource_url
        @status = status
        @created = created
        @completed = completed if completed != OMIT
        @audio_url = audio_url
        @error = error if error != OMIT
        @additional_properties = additional_properties
        @_field_set = {
          "id": id,
          "resource_url": resource_url,
          "status": status,
          "created": created,
          "completed": completed,
          "audio_url": audio_url,
          "error": error
        }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of TranscriptListItem
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TranscriptListItem]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        id = parsed_json["id"]
        resource_url = parsed_json["resource_url"]
        status = parsed_json["status"]
        created = (DateTime.parse(parsed_json["created"]) unless parsed_json["created"].nil?)
        completed = (DateTime.parse(parsed_json["completed"]) unless parsed_json["completed"].nil?)
        audio_url = parsed_json["audio_url"]
        error = parsed_json["error"]
        new(
          id: id,
          resource_url: resource_url,
          status: status,
          created: created,
          completed: completed,
          audio_url: audio_url,
          error: error,
          additional_properties: struct
        )
      end

      # Serialize an instance of TranscriptListItem to a JSON object
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
        obj.id.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.resource_url.is_a?(String) != false || raise("Passed value for field obj.resource_url is not the expected type, validation failed.")
        obj.status.is_a?(AssemblyAI::Transcripts::TranscriptStatus) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
        obj.created.is_a?(DateTime) != false || raise("Passed value for field obj.created is not the expected type, validation failed.")
        obj.completed&.is_a?(DateTime) != false || raise("Passed value for field obj.completed is not the expected type, validation failed.")
        obj.audio_url.is_a?(String) != false || raise("Passed value for field obj.audio_url is not the expected type, validation failed.")
        obj.error&.is_a?(String) != false || raise("Passed value for field obj.error is not the expected type, validation failed.")
      end
    end
  end
end
