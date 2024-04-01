# frozen_string_literal: true

require "json"

module AssemblyAI
  class Realtime
    class TerminateSession
      attr_reader :terminate_session, :additional_properties

      # @param terminate_session [Boolean] Set to true to end your streaming session forever
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::TerminateSession]
      def initialize(terminate_session:, additional_properties: nil)
        # @type [Boolean] Set to true to end your streaming session forever
        @terminate_session = terminate_session
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of TerminateSession
      #
      # @param json_object [JSON]
      # @return [Realtime::TerminateSession]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        terminate_session = struct.terminate_session
        new(terminate_session: terminate_session, additional_properties: struct)
      end

      # Serialize an instance of TerminateSession to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "terminate_session": @terminate_session }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.terminate_session.is_a?(Boolean) != false || raise("Passed value for field obj.terminate_session is not the expected type, validation failed.")
      end
    end
  end
end
