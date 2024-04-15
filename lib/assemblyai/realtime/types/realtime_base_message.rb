# frozen_string_literal: true

require_relative "message_type"
require "ostruct"
require "json"

module AssemblyAI
  class Realtime
    class RealtimeBaseMessage
      # @return [AssemblyAI::Realtime::MessageType] Describes the type of the message
      attr_reader :message_type
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param message_type [AssemblyAI::Realtime::MessageType] Describes the type of the message
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Realtime::RealtimeBaseMessage]
      def initialize(message_type:, additional_properties: nil)
        @message_type = message_type
        @additional_properties = additional_properties
        @_field_set = { "message_type": message_type }
      end

      # Deserialize a JSON object to an instance of RealtimeBaseMessage
      #
      # @param json_object [String]
      # @return [AssemblyAI::Realtime::RealtimeBaseMessage]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        message_type = struct["message_type"]
        new(message_type: message_type, additional_properties: struct)
      end

      # Serialize an instance of RealtimeBaseMessage to a JSON object
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
        obj.message_type.is_a?(AssemblyAI::Realtime::MessageType) != false || raise("Passed value for field obj.message_type is not the expected type, validation failed.")
      end
    end
  end
end
