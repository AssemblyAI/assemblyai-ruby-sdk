# frozen_string_literal: true

require "json"

module AssemblyAI
  class Transcripts
    # Chapter of the audio file
    class Chapter
      attr_reader :gist, :headline, :summary, :start, :end_, :additional_properties

      # @param gist [String] An ultra-short summary (just a few words) of the content spoken in the chapter
      # @param headline [String] A single sentence summary of the content spoken during the chapter
      # @param summary [String] A one paragraph summary of the content spoken during the chapter
      # @param start [Integer] The starting time, in milliseconds, for the chapter
      # @param end_ [Integer] The starting time, in milliseconds, for the chapter
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::Chapter]
      def initialize(gist:, headline:, summary:, start:, end_:, additional_properties: nil)
        # @type [String] An ultra-short summary (just a few words) of the content spoken in the chapter
        @gist = gist
        # @type [String] A single sentence summary of the content spoken during the chapter
        @headline = headline
        # @type [String] A one paragraph summary of the content spoken during the chapter
        @summary = summary
        # @type [Integer] The starting time, in milliseconds, for the chapter
        @start = start
        # @type [Integer] The starting time, in milliseconds, for the chapter
        @end_ = end_
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of Chapter
      #
      # @param json_object [JSON]
      # @return [Transcripts::Chapter]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        gist = struct.gist
        headline = struct.headline
        summary = struct.summary
        start = struct.start
        end_ = struct.end
        new(gist: gist, headline: headline, summary: summary, start: start, end_: end_, additional_properties: struct)
      end

      # Serialize an instance of Chapter to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "gist": @gist, "headline": @headline, "summary": @summary, "start": @start, "end": @end_ }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
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
