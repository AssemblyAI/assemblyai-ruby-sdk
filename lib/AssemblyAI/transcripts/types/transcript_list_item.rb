# frozen_string_literal: true

require "date"
require "json"

module AssemblyAI
  module Transcripts
    class TranscriptListItem
      attr_reader :id, :resource_url, :status, :created, :completed, :audio_url, :additional_properties

      # @param id [String]
      # @param resource_url [String]
      # @param status [Hash{String => String}]
      # @param created [DateTime]
      # @param completed [DateTime]
      # @param audio_url [String]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::TranscriptListItem]
      def initialize(id:, resource_url:, status:, created:, audio_url:, completed: nil, additional_properties: nil)
        # @type [String]
        @id = id
        # @type [String]
        @resource_url = resource_url
        # @type [Hash{String => String}]
        @status = status
        # @type [DateTime]
        @created = created
        # @type [DateTime]
        @completed = completed
        # @type [String]
        @audio_url = audio_url
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TranscriptListItem
      #
      # @param json_object [JSON]
      # @return [Transcripts::TranscriptListItem]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        id = struct.id
        resource_url = struct.resource_url
        status = TRANSCRIPT_STATUS.key(struct.status)
        created = DateTime.parse(struct.created)
        completed = DateTime.parse(struct.completed)
        audio_url = struct.audio_url
        new(id: id, resource_url: resource_url, status: status, created: created, completed: completed,
            audio_url: audio_url, additional_properties: struct)
      end

      # Serialize an instance of TranscriptListItem to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "id": @id,
          "resource_url": @resource_url,
          "status": @status,
          "created": @created,
          "completed": @completed,
          "audio_url": @audio_url
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.id.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.resource_url.is_a?(String) != false || raise("Passed value for field obj.resource_url is not the expected type, validation failed.")
        obj.status.is_a?(TRANSCRIPT_STATUS) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
        obj.created.is_a?(DateTime) != false || raise("Passed value for field obj.created is not the expected type, validation failed.")
        obj.completed&.is_a?(DateTime) != false || raise("Passed value for field obj.completed is not the expected type, validation failed.")
        obj.audio_url.is_a?(String) != false || raise("Passed value for field obj.audio_url is not the expected type, validation failed.")
      end
    end
  end
end
