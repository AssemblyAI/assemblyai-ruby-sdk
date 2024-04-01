# frozen_string_literal: true

require "json"

module AssemblyAI
  class Realtime
    class RealtimeTemporaryTokenResponse
      attr_reader :token, :additional_properties

      # @param token [String] The temporary authentication token for Streaming Speech-to-Text
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::RealtimeTemporaryTokenResponse]
      def initialize(token:, additional_properties: nil)
        # @type [String] The temporary authentication token for Streaming Speech-to-Text
        @token = token
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of RealtimeTemporaryTokenResponse
      #
      # @param json_object [JSON]
      # @return [Realtime::RealtimeTemporaryTokenResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        token = struct.token
        new(token: token, additional_properties: struct)
      end

      # Serialize an instance of RealtimeTemporaryTokenResponse to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "token": @token }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.token.is_a?(String) != false || raise("Passed value for field obj.token is not the expected type, validation failed.")
      end
    end
  end
end
