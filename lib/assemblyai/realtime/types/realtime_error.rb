# frozen_string_literal: true

require "json"

module AssemblyAI
  class Realtime
    class RealtimeError
      attr_reader :error, :additional_properties

      # @param error [String]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::RealtimeError]
      def initialize(error:, additional_properties: nil)
        # @type [String]
        @error = error
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of RealtimeError
      #
      # @param json_object [JSON]
      # @return [Realtime::RealtimeError]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        error = struct.error
        new(error: error, additional_properties: struct)
      end

      # Serialize an instance of RealtimeError to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "error": @error }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.error.is_a?(String) != false || raise("Passed value for field obj.error is not the expected type, validation failed.")
      end
    end
  end
end
