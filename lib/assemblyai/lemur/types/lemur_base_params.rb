# frozen_string_literal: true

require_relative "lemur_base_params_context"
require_relative "lemur_model"
require "json"

module AssemblyAI
  class Lemur
    class LemurBaseParams
      attr_reader :transcript_ids, :input_text, :context, :final_model, :max_output_size, :temperature,
                  :additional_properties

      # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100 hours, whichever is lower.
      #   Use either transcript_ids or input_text as input into LeMUR.
      # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the selected model, which defaults to 100000.
      #   Use either transcript_ids or input_text as input into LeMUR.
      # @param context [Lemur::LemurBaseParamsContext] Context to provide the model. This can be a string or a free-form JSON value.
      # @param final_model [LEMUR_MODEL] The model that is used for the final prompt after compression is performed.
      #   Defaults to "default".
      # @param max_output_size [Integer] Max output size in tokens, up to 4000
      # @param temperature [Float] The temperature to use for the model.
      #   Higher values result in answers that are more creative, lower values are more conservative.
      #   Can be any value between 0.0 and 1.0 inclusive.
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Lemur::LemurBaseParams]
      def initialize(transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                     temperature: nil, additional_properties: nil)
        # @type [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100 hours, whichever is lower.
        #   Use either transcript_ids or input_text as input into LeMUR.
        @transcript_ids = transcript_ids
        # @type [String] Custom formatted transcript data. Maximum size is the context limit of the selected model, which defaults to 100000.
        #   Use either transcript_ids or input_text as input into LeMUR.
        @input_text = input_text
        # @type [Lemur::LemurBaseParamsContext] Context to provide the model. This can be a string or a free-form JSON value.
        @context = context
        # @type [LEMUR_MODEL] The model that is used for the final prompt after compression is performed.
        #   Defaults to "default".
        @final_model = final_model
        # @type [Integer] Max output size in tokens, up to 4000
        @max_output_size = max_output_size
        # @type [Float] The temperature to use for the model.
        #   Higher values result in answers that are more creative, lower values are more conservative.
        #   Can be any value between 0.0 and 1.0 inclusive.
        @temperature = temperature
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of LemurBaseParams
      #
      # @param json_object [JSON]
      # @return [Lemur::LemurBaseParams]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        transcript_ids = struct.transcript_ids
        input_text = struct.input_text
        if parsed_json["context"].nil?
          context = nil
        else
          context = parsed_json["context"].to_json
          context = Lemur::LemurBaseParamsContext.from_json(json_object: context)
        end
        final_model = Lemur::LEMUR_MODEL.key(parsed_json["final_model"]) || parsed_json["final_model"]
        max_output_size = struct.max_output_size
        temperature = struct.temperature
        new(transcript_ids: transcript_ids, input_text: input_text, context: context, final_model: final_model,
            max_output_size: max_output_size, temperature: temperature, additional_properties: struct)
      end

      # Serialize an instance of LemurBaseParams to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "transcript_ids": @transcript_ids,
          "input_text": @input_text,
          "context": @context,
          "final_model": Lemur::LEMUR_MODEL[@final_model] || @final_model,
          "max_output_size": @max_output_size,
          "temperature": @temperature
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.transcript_ids&.is_a?(Array) != false || raise("Passed value for field obj.transcript_ids is not the expected type, validation failed.")
        obj.input_text&.is_a?(String) != false || raise("Passed value for field obj.input_text is not the expected type, validation failed.")
        obj.context.nil? || Lemur::LemurBaseParamsContext.validate_raw(obj: obj.context)
        obj.final_model&.is_a?(Lemur::LEMUR_MODEL) != false || raise("Passed value for field obj.final_model is not the expected type, validation failed.")
        obj.max_output_size&.is_a?(Integer) != false || raise("Passed value for field obj.max_output_size is not the expected type, validation failed.")
        obj.temperature&.is_a?(Float) != false || raise("Passed value for field obj.temperature is not the expected type, validation failed.")
      end
    end
  end
end
