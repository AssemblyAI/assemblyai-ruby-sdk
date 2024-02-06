# frozen_string_literal: true

require "json"

module AssemblyAI
  class Transcripts
    # Timestamp containing a start and end property in milliseconds
    class Timestamp
      attr_reader :start, :end_, :additional_properties

      # @param start [Integer] The start time in milliseconds
      # @param end_ [Integer] The end time in milliseconds
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Transcripts::Timestamp]
      def initialize(start:, end_:, additional_properties: nil)
        # @type [Integer] The start time in milliseconds
        @start = start
        # @type [Integer] The end time in milliseconds
        @end_ = end_
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of Timestamp
      #
      # @param json_object [JSON]
      # @return [Transcripts::Timestamp]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        JSON.parse(json_object)
        start = struct.start
        end_ = struct.end
        new(start: start, end_: end_, additional_properties: struct)
      end

      # Serialize an instance of Timestamp to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "start": @start, "end": @end_ }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.start.is_a?(Integer) != false || raise("Passed value for field obj.start is not the expected type, validation failed.")
        obj.end_.is_a?(Integer) != false || raise("Passed value for field obj.end_ is not the expected type, validation failed.")
      end
    end
  end
end
