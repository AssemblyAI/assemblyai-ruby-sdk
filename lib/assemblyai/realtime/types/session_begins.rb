# frozen_string_literal: true

require "date"
require "ostruct"
require "json"

module AssemblyAI
  class Realtime
    class SessionBegins
      # @return [String] Describes the type of the message
      attr_reader :message_type
      # @return [String] Unique identifier for the established session
      attr_reader :session_id
      # @return [DateTime] Timestamp when this session will expire
      attr_reader :expires_at
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param message_type [String] Describes the type of the message
      # @param session_id [String] Unique identifier for the established session
      # @param expires_at [DateTime] Timestamp when this session will expire
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Realtime::SessionBegins]
      def initialize(message_type:, session_id:, expires_at:, additional_properties: nil)
        @message_type = message_type
        @session_id = session_id
        @expires_at = expires_at
        @additional_properties = additional_properties
        @_field_set = { "message_type": message_type, "session_id": session_id, "expires_at": expires_at }
      end

      # Deserialize a JSON object to an instance of SessionBegins
      #
      # @param json_object [String]
      # @return [AssemblyAI::Realtime::SessionBegins]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        message_type = parsed_json["message_type"]
        session_id = parsed_json["session_id"]
        expires_at = (DateTime.parse(parsed_json["expires_at"]) unless parsed_json["expires_at"].nil?)
        new(
          message_type: message_type,
          session_id: session_id,
          expires_at: expires_at,
          additional_properties: struct
        )
      end

      # Serialize an instance of SessionBegins to a JSON object
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
        obj.message_type.is_a?(String) != false || raise("Passed value for field obj.message_type is not the expected type, validation failed.")
        obj.session_id.is_a?(String) != false || raise("Passed value for field obj.session_id is not the expected type, validation failed.")
        obj.expires_at.is_a?(DateTime) != false || raise("Passed value for field obj.expires_at is not the expected type, validation failed.")
      end
    end
  end
end
