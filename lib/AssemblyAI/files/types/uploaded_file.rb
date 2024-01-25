# frozen_string_literal: true

require "json"

module AssemblyAI
  module Files
    class UploadedFile
      attr_reader :upload_url, :additional_properties

      # @param upload_url [String] A URL that points to your audio file, accessible only by AssemblyAI's servers
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Files::UploadedFile]
      def initialize(upload_url:, additional_properties: nil)
        # @type [String] A URL that points to your audio file, accessible only by AssemblyAI's servers
        @upload_url = upload_url
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of UploadedFile
      #
      # @param json_object [JSON]
      # @return [Files::UploadedFile]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        upload_url = struct.upload_url
        new(upload_url: upload_url, additional_properties: struct)
      end

      # Serialize an instance of UploadedFile to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "upload_url": @upload_url }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.upload_url.is_a?(String) != false || raise("Passed value for field obj.upload_url is not the expected type, validation failed.")
      end
    end
  end
end
