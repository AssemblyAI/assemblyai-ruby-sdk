# frozen_string_literal: true

require "json"
require_relative "../../realtime/types/session_begins"
require_relative "../../realtime/types/partial_transcript"
require_relative "../../realtime/types/final_transcript"
require_relative "../../realtime/types/session_information"
require_relative "../../realtime/types/session_terminated"
require_relative "../../realtime/types/realtime_error"

module AssemblyAI
  class Streaming
    # Receive messages from the WebSocket
    class ReceiveMessage
      # Deserialize a JSON object to an instance of ReceiveMessage
      #
      # @param json_object [String]
      # @return [AssemblyAI::Streaming::ReceiveMessage]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        begin
          AssemblyAI::Realtime::SessionBegins.validate_raw(obj: struct)
          return AssemblyAI::Realtime::SessionBegins.from_json(json_object: json_object) unless json_object.nil?

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Realtime::PartialTranscript.validate_raw(obj: struct)
          return AssemblyAI::Realtime::PartialTranscript.from_json(json_object: json_object) unless json_object.nil?

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Realtime::FinalTranscript.validate_raw(obj: struct)
          return AssemblyAI::Realtime::FinalTranscript.from_json(json_object: json_object) unless json_object.nil?

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Realtime::SessionInformation.validate_raw(obj: struct)
          return AssemblyAI::Realtime::SessionInformation.from_json(json_object: json_object) unless json_object.nil?

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Realtime::SessionTerminated.validate_raw(obj: struct)
          return AssemblyAI::Realtime::SessionTerminated.from_json(json_object: json_object) unless json_object.nil?

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Realtime::RealtimeError.validate_raw(obj: struct)
          return AssemblyAI::Realtime::RealtimeError.from_json(json_object: json_object) unless json_object.nil?

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
          return AssemblyAI::Realtime::SessionBegins.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
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
        begin
          return AssemblyAI::Realtime::SessionInformation.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return AssemblyAI::Realtime::SessionTerminated.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return AssemblyAI::Realtime::RealtimeError.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        raise("Passed value matched no type within the union, validation failed.")
      end
    end
  end
end
