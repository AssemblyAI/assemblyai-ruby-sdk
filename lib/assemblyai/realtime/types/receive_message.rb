# frozen_string_literal: true

require "json"
require_relative "session_begins"
require_relative "partial_transcript"
require_relative "final_transcript"
require_relative "session_terminated"
require_relative "realtime_error"

module AssemblyAI
  class Realtime
    # Receive messages from the WebSocket
    class ReceiveMessage
      # Deserialize a JSON object to an instance of ReceiveMessage
      #
      # @param json_object [JSON]
      # @return [Realtime::ReceiveMessage]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        begin
          Realtime::SessionBegins.validate_raw(obj: struct)
          return Realtime::SessionBegins.from_json(json_object: json_object)
        rescue StandardError
          # noop
        end
        begin
          Realtime::PartialTranscript.validate_raw(obj: struct)
          return Realtime::PartialTranscript.from_json(json_object: json_object)
        rescue StandardError
          # noop
        end
        begin
          Realtime::FinalTranscript.validate_raw(obj: struct)
          return Realtime::FinalTranscript.from_json(json_object: json_object)
        rescue StandardError
          # noop
        end
        begin
          Realtime::SessionTerminated.validate_raw(obj: struct)
          return Realtime::SessionTerminated.from_json(json_object: json_object)
        rescue StandardError
          # noop
        end
        begin
          Realtime::RealtimeError.validate_raw(obj: struct)
          return Realtime::RealtimeError.from_json(json_object: json_object)
        rescue StandardError
          # noop
        end
        struct
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        begin
          return Realtime::SessionBegins.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return Realtime::PartialTranscript.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return Realtime::FinalTranscript.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return Realtime::SessionTerminated.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return Realtime::RealtimeError.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        raise("Passed value matched no type within the union, validation failed.")
      end
    end
  end
end
