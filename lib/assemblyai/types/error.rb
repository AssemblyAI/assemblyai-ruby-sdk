# frozen_string_literal: true

require "json"

module AssemblyAI
  class Error
    attr_reader :error, :status, :additional_properties

    # @param error [String] Error message
    # @param status [String]
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @return [Error]
    def initialize(error:, status: nil, additional_properties: nil)
      # @type [String] Error message
      @error = error
      # @type [String]
      @status = status
      # @type [OpenStruct] Additional properties unmapped to the current class definition
      @additional_properties = additional_properties
    end

    # Deserialize a JSON object to an instance of Error
    #
    # @param json_object [JSON]
    # @return [Error]
    def self.from_json(json_object:)
      struct = JSON.parse(json_object, object_class: OpenStruct)
      JSON.parse(json_object)
      error = struct.error
      status = struct.status
      new(error: error, status: status, additional_properties: struct)
    end

    # Serialize an instance of Error to a JSON object
    #
    # @return [JSON]
    def to_json(*_args)
      { "error": @error, "status": @status }.to_json
    end

    # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
    #
    # @param obj [Object]
    # @return [Void]
    def self.validate_raw(obj:)
      obj.error.is_a?(String) != false || raise("Passed value for field obj.error is not the expected type, validation failed.")
      obj.status&.is_a?(String) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
    end
  end
end
