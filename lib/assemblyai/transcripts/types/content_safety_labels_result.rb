# frozen_string_literal: true

require_relative "audio_intelligence_model_status"
require_relative "content_safety_label_result"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # An array of results for the Content Moderation model, if it is enabled.
    #  See [Content
    #  moderation](https://www.assemblyai.com/docs/models/content-moderation) for more
    #  information.
    class ContentSafetyLabelsResult
      # @return [AssemblyAI::Transcripts::AudioIntelligenceModelStatus] The status of the Content Moderation model. Either success, or unavailable in
      #  the rare case that the model failed.
      attr_reader :status
      # @return [Array<AssemblyAI::Transcripts::ContentSafetyLabelResult>] An array of results for the Content Moderation model
      attr_reader :results
      # @return [Hash{String => Float}] A summary of the Content Moderation confidence results for the entire audio file
      attr_reader :summary
      # @return [Hash{String => AssemblyAI::Transcripts::SeverityScoreSummary}] A summary of the Content Moderation severity results for the entire audio file
      attr_reader :severity_score_summary
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param status [AssemblyAI::Transcripts::AudioIntelligenceModelStatus] The status of the Content Moderation model. Either success, or unavailable in
      #  the rare case that the model failed.
      # @param results [Array<AssemblyAI::Transcripts::ContentSafetyLabelResult>] An array of results for the Content Moderation model
      # @param summary [Hash{String => Float}] A summary of the Content Moderation confidence results for the entire audio file
      # @param severity_score_summary [Hash{String => AssemblyAI::Transcripts::SeverityScoreSummary}] A summary of the Content Moderation severity results for the entire audio file
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::ContentSafetyLabelsResult]
      def initialize(status:, results:, summary:, severity_score_summary:, additional_properties: nil)
        @status = status
        @results = results
        @summary = summary
        @severity_score_summary = severity_score_summary
        @additional_properties = additional_properties
        @_field_set = {
          "status": status,
          "results": results,
          "summary": summary,
          "severity_score_summary": severity_score_summary
        }
      end

      # Deserialize a JSON object to an instance of ContentSafetyLabelsResult
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::ContentSafetyLabelsResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        status = struct["status"]
        results = parsed_json["results"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::ContentSafetyLabelResult.from_json(json_object: v)
        end
        summary = struct["summary"]
        severity_score_summary = parsed_json["severity_score_summary"]&.transform_values do |v|
          v = v.to_json
          AssemblyAI::Transcripts::SeverityScoreSummary.from_json(json_object: v)
        end
        new(
          status: status,
          results: results,
          summary: summary,
          severity_score_summary: severity_score_summary,
          additional_properties: struct
        )
      end

      # Serialize an instance of ContentSafetyLabelsResult to a JSON object
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
        obj.status.is_a?(AssemblyAI::Transcripts::AudioIntelligenceModelStatus) != false || raise("Passed value for field obj.status is not the expected type, validation failed.")
        obj.results.is_a?(Array) != false || raise("Passed value for field obj.results is not the expected type, validation failed.")
        obj.summary.is_a?(Hash) != false || raise("Passed value for field obj.summary is not the expected type, validation failed.")
        obj.severity_score_summary.is_a?(Hash) != false || raise("Passed value for field obj.severity_score_summary is not the expected type, validation failed.")
      end
    end
  end
end
