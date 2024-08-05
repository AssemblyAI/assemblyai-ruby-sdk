# frozen_string_literal: true

require "json"
require_relative "partial_transcript"
require_relative "final_transcript"

module AssemblyAI
  class Realtime
    class RealtimeTranscript
      # Deserialize a JSON object to an instance of RealtimeTranscript
      #
      # @param json_object [String]
      # @return [AssemblyAI::Realtime::RealtimeTranscript]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        begin
          AssemblyAI::Realtime::PartialTranscript.validate_raw(obj: struct)
          return AssemblyAI::Realtime::PartialTranscript.from_json(json_object: struct) unless struct.nil?

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Realtime::FinalTranscript.validate_raw(obj: struct)
          return AssemblyAI::Realtime::FinalTranscript.from_json(json_object: struct) unless struct.nil?

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
          return AssemblyAI::Realtime::PartialTranscript.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return AssemblyAI::Realtime::FinalTranscript.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        raise("Passed value matched no type within the union, validation failed.")
      end
    end
  end
end
