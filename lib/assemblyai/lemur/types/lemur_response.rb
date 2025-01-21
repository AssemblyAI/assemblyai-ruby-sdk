# frozen_string_literal: true

require "json"
require_relative "lemur_string_response"
require_relative "lemur_question_answer_response"

module AssemblyAI
  class Lemur
    class LemurResponse
      # Deserialize a JSON object to an instance of LemurResponse
      #
      # @param json_object [String]
      # @return [AssemblyAI::Lemur::LemurResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        begin
          AssemblyAI::Lemur::LemurStringResponse.validate_raw(obj: struct)
          return AssemblyAI::Lemur::LemurStringResponse.from_json(json_object: struct) unless struct.nil?

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Lemur::LemurQuestionAnswerResponse.validate_raw(obj: struct)
          return AssemblyAI::Lemur::LemurQuestionAnswerResponse.from_json(json_object: struct) unless struct.nil?

          return nil
        rescue StandardError
          # noop
        end
        struct
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given
      #  hash and check each fields type against the current object's property
      #  definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        begin
          return AssemblyAI::Lemur::LemurStringResponse.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return AssemblyAI::Lemur::LemurQuestionAnswerResponse.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        raise("Passed value matched no type within the union, validation failed.")
      end
    end
  end
end
