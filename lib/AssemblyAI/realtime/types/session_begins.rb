# frozen_string_literal: true

require "date"
require "json"

module AssemblyAI
  module Realtime
    class SessionBegins
      attr_reader :message_type, :session_id, :expires_at, :additional_properties

      # @param message_type [String]
      # @param session_id [String] Unique identifier for the established session
      # @param expires_at [DateTime] Timestamp when this session will expire
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::SessionBegins]
      def initialize(message_type:, session_id:, expires_at:, additional_properties: nil)
        # @type [String]
        @message_type = message_type
        # @type [String] Unique identifier for the established session
        @session_id = session_id
        # @type [DateTime] Timestamp when this session will expire
        @expires_at = expires_at
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of SessionBegins
      #
      # @param json_object [JSON]
      # @return [Realtime::SessionBegins]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        message_type = struct.message_type
        session_id = struct.session_id
        expires_at = DateTime.parse(struct.expires_at)
        new(message_type: message_type, session_id: session_id, expires_at: expires_at, additional_properties: struct)
      end

      # Serialize an instance of SessionBegins to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "message_type": @message_type, "session_id": @session_id, "expires_at": @expires_at }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
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
