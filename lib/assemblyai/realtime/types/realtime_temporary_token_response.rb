# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Realtime
    class RealtimeTemporaryTokenResponse
      # @return [String] The temporary authentication token for Streaming Speech-to-Text
      attr_reader :token
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param token [String] The temporary authentication token for Streaming Speech-to-Text
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Realtime::RealtimeTemporaryTokenResponse]
      def initialize(token:, additional_properties: nil)
        @token = token
        @additional_properties = additional_properties
        @_field_set = { "token": token }
      end

      # Deserialize a JSON object to an instance of RealtimeTemporaryTokenResponse
      #
      # @param json_object [String]
      # @return [AssemblyAI::Realtime::RealtimeTemporaryTokenResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        token = parsed_json["token"]
        new(token: token, additional_properties: struct)
      end

      # Serialize an instance of RealtimeTemporaryTokenResponse to a JSON object
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
        obj.token.is_a?(String) != false || raise("Passed value for field obj.token is not the expected type, validation failed.")
      end
    end
  end
end
