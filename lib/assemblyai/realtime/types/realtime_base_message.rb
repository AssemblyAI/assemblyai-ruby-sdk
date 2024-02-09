# frozen_string_literal: true

require_relative "message_type"
require "json"

module AssemblyAI
  class Realtime
    class RealtimeBaseMessage
      attr_reader :message_type, :additional_properties

      # @param message_type [MESSAGE_TYPE] Describes the type of the message
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::RealtimeBaseMessage]
      def initialize(message_type:, additional_properties: nil)
        # @type [MESSAGE_TYPE] Describes the type of the message
        @message_type = message_type
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of RealtimeBaseMessage
      #
      # @param json_object [JSON]
      # @return [Realtime::RealtimeBaseMessage]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        message_type = Realtime::MESSAGE_TYPE.key(parsed_json["message_type"]) || parsed_json["message_type"]
        new(message_type: message_type, additional_properties: struct)
      end

      # Serialize an instance of RealtimeBaseMessage to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "message_type": Realtime::MESSAGE_TYPE[@message_type] || @message_type }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.message_type.is_a?(Realtime::MESSAGE_TYPE) != false || raise("Passed value for field obj.message_type is not the expected type, validation failed.")
      end
    end
  end
end
