# frozen_string_literal: true

require "json"

module AssemblyAI
  module Realtime
    class AudioData
      attr_reader :audio_data, :additional_properties

      # @param audio_data [String] Base64 encoded raw audio data
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::AudioData]
      def initialize(audio_data:, additional_properties: nil)
        # @type [String] Base64 encoded raw audio data
        @audio_data = audio_data
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of AudioData
      #
      # @param json_object [JSON]
      # @return [Realtime::AudioData]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        audio_data = struct.audio_data
        new(audio_data: audio_data, additional_properties: struct)
      end

      # Serialize an instance of AudioData to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "audio_data": @audio_data }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.audio_data.is_a?(String) != false || raise("Passed value for field obj.audio_data is not the expected type, validation failed.")
      end
    end
  end
end
