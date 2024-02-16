# frozen_string_literal: true

require "json"

module AssemblyAI
  class Realtime
    # Manually end an utterance
    class ForceEndUtterance
      attr_reader :force_end_utterance, :additional_properties

      # @param force_end_utterance [Boolean] A boolean value to communicate that you wish to force the end of the utterance
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Realtime::ForceEndUtterance]
      def initialize(force_end_utterance:, additional_properties: nil)
        # @type [Boolean] A boolean value to communicate that you wish to force the end of the utterance
        @force_end_utterance = force_end_utterance
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of ForceEndUtterance
      #
      # @param json_object [JSON]
      # @return [Realtime::ForceEndUtterance]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        force_end_utterance = struct.force_end_utterance
        new(force_end_utterance: force_end_utterance, additional_properties: struct)
      end

      # Serialize an instance of ForceEndUtterance to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "force_end_utterance": @force_end_utterance }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.force_end_utterance.is_a?(Boolean) != false || raise("Passed value for field obj.force_end_utterance is not the expected type, validation failed.")
      end
    end
  end
end
