# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Files
    class UploadedFile
      # @return [String] A URL that points to your audio file, accessible only by AssemblyAI's servers
      attr_reader :upload_url
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param upload_url [String] A URL that points to your audio file, accessible only by AssemblyAI's servers
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Files::UploadedFile]
      def initialize(upload_url:, additional_properties: nil)
        @upload_url = upload_url
        @additional_properties = additional_properties
        @_field_set = { "upload_url": upload_url }
      end

      # Deserialize a JSON object to an instance of UploadedFile
      #
      # @param json_object [String]
      # @return [AssemblyAI::Files::UploadedFile]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        upload_url = parsed_json["upload_url"]
        new(upload_url: upload_url, additional_properties: struct)
      end

      # Serialize an instance of UploadedFile to a JSON object
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
        obj.upload_url.is_a?(String) != false || raise("Passed value for field obj.upload_url is not the expected type, validation failed.")
      end
    end
  end
end
