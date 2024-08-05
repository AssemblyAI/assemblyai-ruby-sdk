# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Realtime
    class TerminateSession
      # @return [Boolean] Set to true to end your streaming session forever
      attr_reader :terminate_session
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param terminate_session [Boolean] Set to true to end your streaming session forever
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Realtime::TerminateSession]
      def initialize(terminate_session:, additional_properties: nil)
        @terminate_session = terminate_session
        @additional_properties = additional_properties
        @_field_set = { "terminate_session": terminate_session }
      end

      # Deserialize a JSON object to an instance of TerminateSession
      #
      # @param json_object [String]
      # @return [AssemblyAI::Realtime::TerminateSession]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        terminate_session = parsed_json["terminate_session"]
        new(terminate_session: terminate_session, additional_properties: struct)
      end

      # Serialize an instance of TerminateSession to a JSON object
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
        obj.terminate_session.is_a?(Boolean) != false || raise("Passed value for field obj.terminate_session is not the expected type, validation failed.")
      end
    end
  end
end
