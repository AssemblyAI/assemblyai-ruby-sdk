# frozen_string_literal: true

require_relative "entity_type"
require "json"

module AssemblyAI
  class Transcripts
    # A detected entity
    class Entity
      attr_reader :entity_type, :text, :start, :end_, :additional_properties

      # @param entity_type [Transcripts::EntityType] The type of entity for the detected entity
      # @param text [String] The text for the detected entity
      # @param start [Integer] The starting time, in milliseconds, at which the detected entity appears in the audio file
      # @param end_ [Integer] The ending time, in milliseconds, for the detected entity in the audio file
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::Entity]
      def initialize(entity_type:, text:, start:, end_:, additional_properties: nil)
        # @type [Transcripts::EntityType] The type of entity for the detected entity
        @entity_type = entity_type
        # @type [String] The text for the detected entity
        @text = text
        # @type [Integer] The starting time, in milliseconds, at which the detected entity appears in the audio file
        @start = start
        # @type [Integer] The ending time, in milliseconds, for the detected entity in the audio file
        @end_ = end_
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of Entity
      #
      # @param json_object [JSON]
      # @return [Transcripts::Entity]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        entity_type = struct.entity_type
        text = struct.text
        start = struct.start
        end_ = struct.end
        new(entity_type: entity_type, text: text, start: start, end_: end_, additional_properties: struct)
      end

      # Serialize an instance of Entity to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "entity_type": @entity_type, "text": @text, "start": @start, "end": @end_ }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.entity_type.is_a?(Transcripts::EntityType) != false || raise("Passed value for field obj.entity_type is not the expected type, validation failed.")
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.start.is_a?(Integer) != false || raise("Passed value for field obj.start is not the expected type, validation failed.")
        obj.end_.is_a?(Integer) != false || raise("Passed value for field obj.end_ is not the expected type, validation failed.")
      end
    end
  end
end
