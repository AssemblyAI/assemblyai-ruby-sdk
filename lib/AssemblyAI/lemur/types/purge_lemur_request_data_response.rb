# frozen_string_literal: true

require "json"

module AssemblyAI
  module Lemur
    class PurgeLemurRequestDataResponse
      attr_reader :request_id, :request_id_to_purge, :deleted, :additional_properties

      # @param request_id [String] The ID of the deletion request of the LeMUR request
      # @param request_id_to_purge [String] The ID of the LeMUR request to purge the data for
      # @param deleted [Boolean] Whether the request data was deleted
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Lemur::PurgeLemurRequestDataResponse]
      def initialize(request_id:, request_id_to_purge:, deleted:, additional_properties: nil)
        # @type [String] The ID of the deletion request of the LeMUR request
        @request_id = request_id
        # @type [String] The ID of the LeMUR request to purge the data for
        @request_id_to_purge = request_id_to_purge
        # @type [Boolean] Whether the request data was deleted
        @deleted = deleted
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of PurgeLemurRequestDataResponse
      #
      # @param json_object [JSON]
      # @return [Lemur::PurgeLemurRequestDataResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        request_id = struct.request_id
        request_id_to_purge = struct.request_id_to_purge
        deleted = struct.deleted
        new(request_id: request_id, request_id_to_purge: request_id_to_purge, deleted: deleted,
            additional_properties: struct)
      end

      # Serialize an instance of PurgeLemurRequestDataResponse to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "request_id": @request_id, "request_id_to_purge": @request_id_to_purge, "deleted": @deleted }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.request_id.is_a?(String) != false || raise("Passed value for field obj.request_id is not the expected type, validation failed.")
        obj.request_id_to_purge.is_a?(String) != false || raise("Passed value for field obj.request_id_to_purge is not the expected type, validation failed.")
        obj.deleted.is_a?(Boolean) != false || raise("Passed value for field obj.deleted is not the expected type, validation failed.")
      end
    end
  end
end
