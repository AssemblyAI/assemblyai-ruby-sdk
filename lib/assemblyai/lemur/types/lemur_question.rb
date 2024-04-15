# frozen_string_literal: true

require_relative "lemur_question_context"
require "ostruct"
require "json"

module AssemblyAI
  class Lemur
    class LemurQuestion
      # @return [String] The question you wish to ask. For more complex questions use default model.
      attr_reader :question
      # @return [AssemblyAI::Lemur::LemurQuestionContext] Any context about the transcripts you wish to provide. This can be a string or
      #  any object.
      attr_reader :context
      # @return [String] How you want the answer to be returned. This can be any text. Can't be used with
      #  answer_options. Examples: "short sentence", "bullet points"
      attr_reader :answer_format
      # @return [Array<String>] What discrete options to return. Useful for precise responses. Can't be used
      #  with answer_format. Example: ["Yes", "No"]
      attr_reader :answer_options
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param question [String] The question you wish to ask. For more complex questions use default model.
      # @param context [AssemblyAI::Lemur::LemurQuestionContext] Any context about the transcripts you wish to provide. This can be a string or
      #  any object.
      # @param answer_format [String] How you want the answer to be returned. This can be any text. Can't be used with
      #  answer_options. Examples: "short sentence", "bullet points"
      # @param answer_options [Array<String>] What discrete options to return. Useful for precise responses. Can't be used
      #  with answer_format. Example: ["Yes", "No"]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Lemur::LemurQuestion]
      def initialize(question:, context: OMIT, answer_format: OMIT, answer_options: OMIT, additional_properties: nil)
        @question = question
        @context = context if context != OMIT
        @answer_format = answer_format if answer_format != OMIT
        @answer_options = answer_options if answer_options != OMIT
        @additional_properties = additional_properties
        @_field_set = {
          "question": question,
          "context": context,
          "answer_format": answer_format,
          "answer_options": answer_options
        }.reject do |_k, v|
          v == OMIT
        end
      end

      # Deserialize a JSON object to an instance of LemurQuestion
      #
      # @param json_object [String]
      # @return [AssemblyAI::Lemur::LemurQuestion]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        question = struct["question"]
        if parsed_json["context"].nil?
          context = nil
        else
          context = parsed_json["context"].to_json
          context = AssemblyAI::Lemur::LemurQuestionContext.from_json(json_object: context)
        end
        answer_format = struct["answer_format"]
        answer_options = struct["answer_options"]
        new(
          question: question,
          context: context,
          answer_format: answer_format,
          answer_options: answer_options,
          additional_properties: struct
        )
      end

      # Serialize an instance of LemurQuestion to a JSON object
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
        obj.question.is_a?(String) != false || raise("Passed value for field obj.question is not the expected type, validation failed.")
        obj.context.nil? || AssemblyAI::Lemur::LemurQuestionContext.validate_raw(obj: obj.context)
        obj.answer_format&.is_a?(String) != false || raise("Passed value for field obj.answer_format is not the expected type, validation failed.")
        obj.answer_options&.is_a?(Array) != false || raise("Passed value for field obj.answer_options is not the expected type, validation failed.")
      end
    end
  end
end
