# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Realtime
    # Manually end an utterance
    class ForceEndUtterance
      # @return [Boolean] A boolean value to communicate that you wish to force the end of the utterance
      attr_reader :force_end_utterance
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param force_end_utterance [Boolean] A boolean value to communicate that you wish to force the end of the utterance
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Realtime::ForceEndUtterance]
      def initialize(force_end_utterance:, additional_properties: nil)
        @force_end_utterance = force_end_utterance
        @additional_properties = additional_properties
        @_field_set = { "force_end_utterance": force_end_utterance }
      end

      # Deserialize a JSON object to an instance of ForceEndUtterance
      #
      # @param json_object [String]
      # @return [AssemblyAI::Realtime::ForceEndUtterance]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        force_end_utterance = struct["force_end_utterance"]
        new(force_end_utterance: force_end_utterance, additional_properties: struct)
      end

      # Serialize an instance of ForceEndUtterance to a JSON object
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
        obj.force_end_utterance.is_a?(Boolean) != false || raise("Passed value for field obj.force_end_utterance is not the expected type, validation failed.")
      end
    end
  end
end
