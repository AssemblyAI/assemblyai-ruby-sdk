# frozen_string_literal: true

require "json"

module AssemblyAI
  class Realtime
    # Configure the threshold for how long to wait before ending an utterance. Default is 700ms.
    class ConfigureEndUtteranceSilenceThreshold
      attr_reader :end_utterance_silence_threshold, :additional_properties

      # @param end_utterance_silence_threshold [Integer] The duration threshold in milliseconds
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::ConfigureEndUtteranceSilenceThreshold]
      def initialize(end_utterance_silence_threshold:, additional_properties: nil)
        # @type [Integer] The duration threshold in milliseconds
        @end_utterance_silence_threshold = end_utterance_silence_threshold
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of ConfigureEndUtteranceSilenceThreshold
      #
      # @param json_object [JSON]
      # @return [Realtime::ConfigureEndUtteranceSilenceThreshold]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        end_utterance_silence_threshold = struct.end_utterance_silence_threshold
        new(end_utterance_silence_threshold: end_utterance_silence_threshold, additional_properties: struct)
      end

      # Serialize an instance of ConfigureEndUtteranceSilenceThreshold to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "end_utterance_silence_threshold": @end_utterance_silence_threshold }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.end_utterance_silence_threshold.is_a?(Integer) != false || raise("Passed value for field obj.end_utterance_silence_threshold is not the expected type, validation failed.")
      end
    end
  end
end
