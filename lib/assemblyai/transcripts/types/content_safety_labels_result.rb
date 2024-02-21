# frozen_string_literal: true

require_relative "audio_intelligence_model_status"
require_relative "content_safety_label_result"
require "json"

module AssemblyAI
  class Transcripts
    # An array of results for the Content Moderation model, if it is enabled.
    # See [Content moderation](https://www.assemblyai.com/docs/models/content-moderation) for more information.
    class ContentSafetyLabelsResult
      attr_reader :status, :results, :summary, :severity_score_summary, :additional_properties

      # @param status [Transcripts::AudioIntelligenceModelStatus] The status of the Content Moderation model. Either success, or unavailable in the rare case that the model failed.
      # @param results [Array<Transcripts::ContentSafetyLabelResult>]
      # @param summary [Hash{String => String}] A summary of the Content Moderation confidence results for the entire audio file
      # @param severity_score_summary [Hash{String => String}] A summary of the Content Moderation severity results for the entire audio file
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::ContentSafetyLabelsResult]
      def initialize(status:, results:, summary:, severity_score_summary:, additional_properties: nil)
        # @type [Transcripts::AudioIntelligenceModelStatus] The status of the Content Moderation model. Either success, or unavailable in the rare case that the model failed.
        @status = status
        # @type [Array<Transcripts::ContentSafetyLabelResult>]
        @results = results
        # @type [Hash{String => String}] A summary of the Content Moderation confidence results for the entire audio file
        @summary = summary
        # @type [Hash{String => String}] A summary of the Content Moderation severity results for the entire audio file
        @severity_score_summary = severity_score_summary
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of ContentSafetyLabelsResult
      #
      # @param json_object [JSON]
      # @return [Transcripts::ContentSafetyLabelsResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        status = struct.status
        results = parsed_json["results"]&.map do |v|
          v = v.to_json
          Transcripts::ContentSafetyLabelResult.from_json(json_object: v)
        end
        summary = struct.summary
        severity_score_summary = struct.severity_score_summary
        new(status: status, results: results, summary: summary, severity_score_summary: severity_score_summary,
            additional_properties: struct)
      end

      # Serialize an instance of ContentSafetyLabelsResult to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "status": @status,
          "results": @results,
          "summary": @summary,
          "severity_score_summary": @severity_score_summary
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.status.is_a?(Transcripts::AudioIntelligenceModelStatus) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
        obj.results.is_a?(Array) != false || raise("Passed value for field obj.results is not the expected type, validation failed.")
        obj.summary.is_a?(Hash) != false || raise("Passed value for field obj.summary is not the expected type, validation failed.")
        obj.severity_score_summary.is_a?(Hash) != false || raise("Passed value for field obj.severity_score_summary is not the expected type, validation failed.")
      end
    end
  end
end
