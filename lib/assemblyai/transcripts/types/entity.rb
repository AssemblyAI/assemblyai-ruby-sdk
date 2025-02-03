# frozen_string_literal: true

require_relative "entity_type"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # A detected entity
    class Entity
      # @return [AssemblyAI::Transcripts::EntityType] The type of entity for the detected entity
      attr_reader :entity_type
      # @return [String] The text for the detected entity
      attr_reader :text
      # @return [Integer] The starting time, in milliseconds, at which the detected entity appears in the
      #  audio file
      attr_reader :start
      # @return [Integer] The ending time, in milliseconds, for the detected entity in the audio file
      attr_reader :end_
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param entity_type [AssemblyAI::Transcripts::EntityType] The type of entity for the detected entity
      # @param text [String] The text for the detected entity
      # @param start [Integer] The starting time, in milliseconds, at which the detected entity appears in the
      #  audio file
      # @param end_ [Integer] The ending time, in milliseconds, for the detected entity in the audio file
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::Entity]
      def initialize(entity_type:, text:, start:, end_:, additional_properties: nil)
        @entity_type = entity_type
        @text = text
        @start = start
        @end_ = end_
        @additional_properties = additional_properties
        @_field_set = { "entity_type": entity_type, "text": text, "start": start, "end": end_ }
      end

      # Deserialize a JSON object to an instance of Entity
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::Entity]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        entity_type = parsed_json["entity_type"]
        text = parsed_json["text"]
        start = parsed_json["start"]
        end_ = parsed_json["end"]
        new(
          entity_type: entity_type,
          text: text,
          start: start,
          end_: end_,
          additional_properties: struct
        )
      end

      # Serialize an instance of Entity to a JSON object
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
        obj.entity_type.is_a?(AssemblyAI::Transcripts::EntityType) != false || raise("Passed value for field obj.entity_type is not the expected type, validation failed.")
        obj.text.is_a?(String) != false || raise("Passed value for field obj.text is not the expected type, validation failed.")
        obj.start.is_a?(Integer) != false || raise("Passed value for field obj.start is not the expected type, validation failed.")
        obj.end_.is_a?(Integer) != false || raise("Passed value for field obj.end_ is not the expected type, validation failed.")
      end
    end
  end
end
