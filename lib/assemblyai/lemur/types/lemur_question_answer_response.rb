# frozen_string_literal: true

require_relative "lemur_question_answer"
require "json"

module AssemblyAI
  class Lemur
    class LemurQuestionAnswerResponse
      attr_reader :response, :request_id, :additional_properties

      # @param response [Array<Lemur::LemurQuestionAnswer>] The answers generated by LeMUR and their questions
      # @param request_id [String] The ID of the LeMUR request
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Lemur::LemurQuestionAnswerResponse]
      def initialize(response:, request_id:, additional_properties: nil)
        # @type [Array<Lemur::LemurQuestionAnswer>] The answers generated by LeMUR and their questions
        @response = response
        # @type [String] The ID of the LeMUR request
        @request_id = request_id
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of LemurQuestionAnswerResponse
      #
      # @param json_object [JSON]
      # @return [Lemur::LemurQuestionAnswerResponse]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        response = parsed_json["response"]&.map do |v|
          v = v.to_json
          Lemur::LemurQuestionAnswer.from_json(json_object: v)
        end
        request_id = struct.request_id
        new(response: response, request_id: request_id, additional_properties: struct)
      end

      # Serialize an instance of LemurQuestionAnswerResponse to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "response": @response, "request_id": @request_id }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
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