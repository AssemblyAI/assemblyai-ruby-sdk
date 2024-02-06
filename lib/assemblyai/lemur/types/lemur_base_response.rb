# frozen_string_literal: true

require "json"

module AssemblyAI
  class Lemur
    class LemurBaseResponse
      attr_reader :request_id, :additional_properties

      # @param request_id [String] The ID of the LeMUR request
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Lemur::LemurBaseResponse]
      def initialize(request_id:, additional_properties: nil)
        # @type [String] The ID of the LeMUR request
        @request_id = request_id
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of LemurBaseResponse
      #
      # @param json_object [JSON]
      # @return [Lemur::LemurBaseResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        request_id = struct.request_id
        new(request_id: request_id, additional_properties: struct)
      end

      # Serialize an instance of LemurBaseResponse to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "request_id": @request_id }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.request_id.is_a?(String) != false || raise("Passed value for field obj.request_id is not the expected type, validation failed.")
      end
    end
  end
end
