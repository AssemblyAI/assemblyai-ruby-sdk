# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Lemur
    class LemurBaseResponse
      # @return [String] The ID of the LeMUR request
      attr_reader :request_id
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param request_id [String] The ID of the LeMUR request
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Lemur::LemurBaseResponse]
      def initialize(request_id:, additional_properties: nil)
        @request_id = request_id
        @additional_properties = additional_properties
        @_field_set = { "request_id": request_id }
      end

      # Deserialize a JSON object to an instance of LemurBaseResponse
      #
      # @param json_object [String]
      # @return [AssemblyAI::Lemur::LemurBaseResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        request_id = struct["request_id"]
        new(request_id: request_id, additional_properties: struct)
      end

      # Serialize an instance of LemurBaseResponse to a JSON object
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
        obj.request_id.is_a?(String) != false || raise("Passed value for field obj.request_id is not the expected type, validation failed.")
      end
    end
  end
end
