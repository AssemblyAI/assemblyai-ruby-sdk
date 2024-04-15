# frozen_string_literal: true

require_relative "lemur_question_answer"
require "ostruct"
require "json"

module AssemblyAI
  class Lemur
    class LemurQuestionAnswerResponse
      # @return [Array<AssemblyAI::Lemur::LemurQuestionAnswer>] The answers generated by LeMUR and their questions
      attr_reader :response
      # @return [String] The ID of the LeMUR request
      attr_reader :request_id
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param response [Array<AssemblyAI::Lemur::LemurQuestionAnswer>] The answers generated by LeMUR and their questions
      # @param request_id [String] The ID of the LeMUR request
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Lemur::LemurQuestionAnswerResponse]
      def initialize(response:, request_id:, additional_properties: nil)
        @response = response
        @request_id = request_id
        @additional_properties = additional_properties
        @_field_set = { "response": response, "request_id": request_id }
      end

      # Deserialize a JSON object to an instance of LemurQuestionAnswerResponse
      #
      # @param json_object [String]
      # @return [AssemblyAI::Lemur::LemurQuestionAnswerResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        response = parsed_json["response"]&.map do |v|
          v = v.to_json
          AssemblyAI::Lemur::LemurQuestionAnswer.from_json(json_object: v)
        end
        request_id = struct["request_id"]
        new(
          response: response,
          request_id: request_id,
          additional_properties: struct
        )
      end

      # Serialize an instance of LemurQuestionAnswerResponse to a JSON object
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
        obj.response.is_a?(Array) != false || raise("Passed value for field obj.response is not the expected type, validation failed.")
        obj.request_id.is_a?(String) != false || raise("Passed value for field obj.request_id is not the expected type, validation failed.")
      end
    end
  end
end
