# frozen_string_literal: true

require_relative "audio_intelligence_model_status"
require_relative "auto_highlight_result"
require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # An array of results for the Key Phrases model, if it is enabled.
    #  See [Key phrases](https://www.assemblyai.com/docs/models/key-phrases) for more
    #  information.
    class AutoHighlightsResult
      # @return [AssemblyAI::Transcripts::AudioIntelligenceModelStatus] The status of the Key Phrases model. Either success, or unavailable in the rare
      #  case that the model failed.
      attr_reader :status
      # @return [Array<AssemblyAI::Transcripts::AutoHighlightResult>] A temporally-sequential array of Key Phrases
      attr_reader :results
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param status [AssemblyAI::Transcripts::AudioIntelligenceModelStatus] The status of the Key Phrases model. Either success, or unavailable in the rare
      #  case that the model failed.
      # @param results [Array<AssemblyAI::Transcripts::AutoHighlightResult>] A temporally-sequential array of Key Phrases
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::AutoHighlightsResult]
      def initialize(status:, results:, additional_properties: nil)
        @status = status
        @results = results
        @additional_properties = additional_properties
        @_field_set = { "status": status, "results": results }
      end

      # Deserialize a JSON object to an instance of AutoHighlightsResult
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::AutoHighlightsResult]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        status = struct["status"]
        results = parsed_json["results"]&.map do |v|
          v = v.to_json
          AssemblyAI::Transcripts::AutoHighlightResult.from_json(json_object: v)
        end
        new(
          status: status,
          results: results,
          additional_properties: struct
        )
      end

      # Serialize an instance of AutoHighlightsResult to a JSON object
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
      end
    end
  end
end
