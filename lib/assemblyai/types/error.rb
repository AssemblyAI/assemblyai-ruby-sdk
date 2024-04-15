# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Error
    # @return [String] Error message
    attr_reader :error
    # @return [String]
    attr_reader :status
    # @return [OpenStruct] Additional properties unmapped to the current class definition
    attr_reader :additional_properties
    # @return [Object]
    attr_reader :_field_set
    protected :_field_set

    OMIT = Object.new

    # @param error [String] Error message
    # @param status [String]
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @return [AssemblyAI::Error]
    def initialize(error:, status: OMIT, additional_properties: nil)
      @error = error
      @status = status if status != OMIT
      @additional_properties = additional_properties
      @_field_set = { "error": error, "status": status }.reject do |_k, v|
        v == OMIT
      end
    end

    # Deserialize a JSON object to an instance of Error
    #
    # @param json_object [String]
    # @return [AssemblyAI::Error]
    def self.from_json(json_object:)
      struct = JSON.parse(json_object, object_class: OpenStruct)
      error = struct["error"]
      status = struct["status"]
      new(
        error: error,
        status: status,
        additional_properties: struct
      )
    end

    # Serialize an instance of Error to a JSON object
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
      obj.error.is_a?(String) != false || raise("Passed value for field obj.error is not the expected type, validation failed.")
      obj.status&.is_a?(String) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
    end
  end
end
