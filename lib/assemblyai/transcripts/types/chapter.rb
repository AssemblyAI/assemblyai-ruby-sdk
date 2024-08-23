# frozen_string_literal: true

require "ostruct"
require "json"

module AssemblyAI
  class Transcripts
    # Chapter of the audio file
    class Chapter
      # @return [String] An ultra-short summary (just a few words) of the content spoken in the chapter
      attr_reader :gist
      # @return [String] A single sentence summary of the content spoken during the chapter
      attr_reader :headline
      # @return [String] A one paragraph summary of the content spoken during the chapter
      attr_reader :summary
      # @return [Integer] The starting time, in milliseconds, for the chapter
      attr_reader :start
      # @return [Integer] The starting time, in milliseconds, for the chapter
      attr_reader :end_
      # @return [OpenStruct] Additional properties unmapped to the current class definition
      attr_reader :additional_properties
      # @return [Object]
      attr_reader :_field_set
      protected :_field_set

      OMIT = Object.new

      # @param gist [String] An ultra-short summary (just a few words) of the content spoken in the chapter
      # @param headline [String] A single sentence summary of the content spoken during the chapter
      # @param summary [String] A one paragraph summary of the content spoken during the chapter
      # @param start [Integer] The starting time, in milliseconds, for the chapter
      # @param end_ [Integer] The starting time, in milliseconds, for the chapter
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [AssemblyAI::Transcripts::Chapter]
      def initialize(gist:, headline:, summary:, start:, end_:, additional_properties: nil)
        @gist = gist
        @headline = headline
        @summary = summary
        @start = start
        @end_ = end_
        @additional_properties = additional_properties
        @_field_set = { "gist": gist, "headline": headline, "summary": summary, "start": start, "end": end_ }
      end

      # Deserialize a JSON object to an instance of Chapter
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::Chapter]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        gist = parsed_json["gist"]
        headline = parsed_json["headline"]
        summary = parsed_json["summary"]
        start = parsed_json["start"]
        end_ = parsed_json["end"]
        new(
          gist: gist,
          headline: headline,
          summary: summary,
          start: start,
          end_: end_,
          additional_properties: struct
        )
      end

      # Serialize an instance of Chapter to a JSON object
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
        obj.gist.is_a?(String) != false || raise("Passed value for field obj.gist is not the expected type, validation failed.")
        obj.headline.is_a?(String) != false || raise("Passed value for field obj.headline is not the expected type, validation failed.")
        obj.summary.is_a?(String) != false || raise("Passed value for field obj.summary is not the expected type, validation failed.")
        obj.start.is_a?(Integer) != false || raise("Passed value for field obj.start is not the expected type, validation failed.")
        obj.end_.is_a?(Integer) != false || raise("Passed value for field obj.end_ is not the expected type, validation failed.")
      end
    end
  end
end
