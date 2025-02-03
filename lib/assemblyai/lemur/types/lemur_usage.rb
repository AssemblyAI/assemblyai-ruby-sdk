# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Lemur
    # The usage numbers for the LeMUR request
    class LemurUsage
      # @return [Integer] The number of input tokens used by the model
      attr_reader :input_tokens
      # @return [Integer] The number of output tokens generated by the model
      attr_reader :output_tokens
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param input_tokens [Integer] The number of input tokens used by the model
      # @param output_tokens [Integer] The number of output tokens generated by the model
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Lemur::LemurUsage]
      def initialize(input_tokens:, output_tokens:, additional_properties: nil)
        @input_tokens = input_tokens
        @output_tokens = output_tokens
        @additional_properties = additional_properties
        @_field_set = { "input_tokens": input_tokens, "output_tokens": output_tokens }
      end

      # Deserialize a JSON object to an instance of LemurUsage
      #
      # @param json_object [String]
      # @return [AssemblyAI::Lemur::LemurUsage]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        input_tokens = parsed_json["input_tokens"]
        output_tokens = parsed_json["output_tokens"]
        new(
          input_tokens: input_tokens,
          output_tokens: output_tokens,
          additional_properties: struct
        )
      end

      # Serialize an instance of LemurUsage to a JSON object
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
        obj.input_tokens.is_a?(Integer) != false || raise("Passed value for field obj.input_tokens is not the expected type, validation failed.")
        obj.output_tokens.is_a?(Integer) != false || raise("Passed value for field obj.output_tokens is not the expected type, validation failed.")
      end
    end
  end
end
