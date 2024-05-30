# frozen_string_literal: true

require_relative "lemur_base_params_context"
require_relative "lemur_model"
require "ostruct"
require "json"

module AssemblyAI
  class Lemur
    class LemurBaseParams
      # @return [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100
      #  hours, whichever is lower.
      #  Use either transcript_ids or input_text as input into LeMUR.
      attr_reader :transcript_ids
      # @return [String] Custom formatted transcript data. Maximum size is the context limit of the
      #  selected model, which defaults to 100000.
      #  Use either transcript_ids or input_text as input into LeMUR.
      attr_reader :input_text
      # @return [AssemblyAI::Lemur::LemurBaseParamsContext] Context to provide the model. This can be a string or a free-form JSON value.
      attr_reader :context
      # @return [AssemblyAI::Lemur::LemurModel] The model that is used for the final prompt after compression is performed.
      #  Defaults to "default".
      attr_reader :final_model
      # @return [Integer] Max output size in tokens, up to 4000
      attr_reader :max_output_size
      # @return [Float] The temperature to use for the model.
      #  Higher values result in answers that are more creative, lower values are more
      #  conservative.
      #  Can be any value between 0.0 and 1.0 inclusive.
      attr_reader :temperature
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100
      #  hours, whichever is lower.
      #  Use either transcript_ids or input_text as input into LeMUR.
      # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the
      #  selected model, which defaults to 100000.
      #  Use either transcript_ids or input_text as input into LeMUR.
      # @param context [AssemblyAI::Lemur::LemurBaseParamsContext] Context to provide the model. This can be a string or a free-form JSON value.
      # @param final_model [AssemblyAI::Lemur::LemurModel] The model that is used for the final prompt after compression is performed.
      #  Defaults to "default".
      # @param max_output_size [Integer] Max output size in tokens, up to 4000
      # @param temperature [Float] The temperature to use for the model.
      #  Higher values result in answers that are more creative, lower values are more
      #  conservative.
      #  Can be any value between 0.0 and 1.0 inclusive.
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Lemur::LemurBaseParams]
      def initialize(transcript_ids: OMIT, input_text: OMIT, context: OMIT, final_model: OMIT, max_output_size: OMIT,
                     temperature: OMIT, additional_properties: nil)
        @transcript_ids = transcript_ids if transcript_ids != OMIT
        @input_text = input_text if input_text != OMIT
        @context = context if context != OMIT
        @final_model = final_model if final_model != OMIT
        @max_output_size = max_output_size if max_output_size != OMIT
        @temperature = temperature if temperature != OMIT
        @additional_properties = additional_properties
        @_field_set = {
          "transcript_ids": transcript_ids,
          "input_text": input_text,
          "context": context,
          "final_model": final_model,
          "max_output_size": max_output_size,
          "temperature": temperature
        }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of LemurBaseParams
      #
      # @param json_object [String]
      # @return [AssemblyAI::Lemur::LemurBaseParams]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        transcript_ids = struct["transcript_ids"]
        input_text = struct["input_text"]
        if parsed_json["context"].nil?
          context = nil
        else
          context = parsed_json["context"].to_json
          context = AssemblyAI::Lemur::LemurBaseParamsContext.from_json(json_object: context)
        end
        final_model = struct["final_model"]
        max_output_size = struct["max_output_size"]
        temperature = struct["temperature"]
        new(
          transcript_ids: transcript_ids,
          input_text: input_text,
          context: context,
          final_model: final_model,
          max_output_size: max_output_size,
          temperature: temperature,
          additional_properties: struct
        )
      end

      # Serialize an instance of LemurBaseParams to a JSON object
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
        obj.transcript_ids&.is_a?(Array) != false || raise("Passed value for field obj.transcript_ids is not the expected type, validation failed.")
        obj.input_text&.is_a?(String) != false || raise("Passed value for field obj.input_text is not the expected type, validation failed.")
        obj.context.nil? || AssemblyAI::Lemur::LemurBaseParamsContext.validate_raw(obj: obj.context)
        obj.final_model&.is_a?(AssemblyAI::Lemur::LemurModel) != false || raise("Passed value for field obj.final_model is not the expected type, validation failed.")
        obj.max_output_size&.is_a?(Integer) != false || raise("Passed value for field obj.max_output_size is not the expected type, validation failed.")
        obj.temperature&.is_a?(Float) != false || raise("Passed value for field obj.temperature is not the expected type, validation failed.")
      end
    end
  end
end
