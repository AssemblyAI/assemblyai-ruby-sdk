# frozen_string_literal: true

require_relative "message_type"
require "json"

module AssemblyAI
  class Realtime
    class TerminateSession
      attr_reader :terminate_session, :message_type, :additional_properties

      # @param terminate_session [Boolean] Set to true to end your real-time session forever
      # @param message_type [MESSAGE_TYPE] Describes the type of the message
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::TerminateSession]
      def initialize(terminate_session:, message_type:, additional_properties: nil)
        # @type [Boolean] Set to true to end your real-time session forever
        @terminate_session = terminate_session
        # @type [MESSAGE_TYPE] Describes the type of the message
        @message_type = message_type
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TerminateSession
      #
      # @param json_object [JSON]
      # @return [Realtime::TerminateSession]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        terminate_session = struct.terminate_session
        message_type = Realtime::MESSAGE_TYPE.key(parsed_json["message_type"]) || parsed_json["message_type"]
        new(terminate_session: terminate_session, message_type: message_type, additional_properties: struct)
      end

      # Serialize an instance of TerminateSession to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "terminate_session": @terminate_session,
          "message_type": Realtime::MESSAGE_TYPE[@message_type] || @message_type
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.terminate_session.is_a?(Boolean) != false || raise("Passed value for field obj.terminate_session is not the expected type, validation failed.")
        obj.message_type.is_a?(Realtime::MESSAGE_TYPE) != false || raise("Passed value for field obj.message_type is not the expected type, validation failed.")
      end
    end
  end
end
