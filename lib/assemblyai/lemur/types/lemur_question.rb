# frozen_string_literal: true

require_relative "lemur_question_context"
require "json"

module AssemblyAI
  class Lemur
    class LemurQuestion
      attr_reader :question, :context, :answer_format, :answer_options, :additional_properties

      # @param question [String] The question you wish to ask. For more complex questions use default model.
      # @param context [Lemur::LemurQuestionContext] Any context about the transcripts you wish to provide. This can be a string or any object.
      # @param answer_format [String] How you want the answer to be returned. This can be any text. Can't be used with answer_options. Examples: "short sentence", "bullet points"
      # @param answer_options [Array<String>] What discrete options to return. Useful for precise responses. Can't be used with answer_format. Example: ["Yes", "No"]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Lemur::LemurQuestion]
      def initialize(question:, context: nil, answer_format: nil, answer_options: nil, additional_properties: nil)
        # @type [String] The question you wish to ask. For more complex questions use default model.
        @question = question
        # @type [Lemur::LemurQuestionContext] Any context about the transcripts you wish to provide. This can be a string or any object.
        @context = context
        # @type [String] How you want the answer to be returned. This can be any text. Can't be used with answer_options. Examples: "short sentence", "bullet points"
        @answer_format = answer_format
        # @type [Array<String>] What discrete options to return. Useful for precise responses. Can't be used with answer_format. Example: ["Yes", "No"]
        @answer_options = answer_options
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of LemurQuestion
      #
      # @param json_object [JSON]
      # @return [Lemur::LemurQuestion]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        question = struct.question
        if parsed_json["context"].nil?
          context = nil
        else
          context = parsed_json["context"].to_json
          context = Lemur::LemurQuestionContext.from_json(json_object: context)
        end
        answer_format = struct.answer_format
        answer_options = struct.answer_options
        new(question: question, context: context, answer_format: answer_format, answer_options: answer_options,
            additional_properties: struct)
      end

      # Serialize an instance of LemurQuestion to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "question": @question,
          "context": @context,
          "answer_format": @answer_format,
          "answer_options": @answer_options
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.question.is_a?(String) != false || raise("Passed value for field obj.question is not the expected type, validation failed.")
        obj.context.nil? || Lemur::LemurQuestionContext.validate_raw(obj: obj.context)
        obj.answer_format&.is_a?(String) != false || raise("Passed value for field obj.answer_format is not the expected type, validation failed.")
        obj.answer_options&.is_a?(Array) != false || raise("Passed value for field obj.answer_options is not the expected type, validation failed.")
      end
    end
  end
end
