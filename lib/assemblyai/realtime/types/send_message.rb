# frozen_string_literal: true

require "json"
require_relative "terminate_session"
require_relative "force_end_utterance"
require_relative "configure_end_utterance_silence_threshold"

module AssemblyAI
  class Realtime
    # Send messages to the WebSocket
    class SendMessage
      # Deserialize a JSON object to an instance of SendMessage
      #
      # @param json_object [String]
      # @return [AssemblyAI::Realtime::SendMessage]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        begin
          struct.is_a?(String) != false || raise("Passed value for field struct is not the expected type, validation failed.")
          return struct unless struct.nil?

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Realtime::TerminateSession.validate_raw(obj: struct)
          return AssemblyAI::Realtime::TerminateSession.from_json(json_object: struct) unless struct.nil?

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Realtime::ForceEndUtterance.validate_raw(obj: struct)
          return AssemblyAI::Realtime::ForceEndUtterance.from_json(json_object: struct) unless struct.nil?

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Realtime::ConfigureEndUtteranceSilenceThreshold.validate_raw(obj: struct)
          unless struct.nil?
            return AssemblyAI::Realtime::ConfigureEndUtteranceSilenceThreshold.from_json(json_object: struct)
          end

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
          return obj.is_a?(String) != false || raise("Passed value for field obj is not the expected type, validation failed.")
        rescue StandardError
          # noop
        end
        begin
          return AssemblyAI::Realtime::TerminateSession.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return AssemblyAI::Realtime::ForceEndUtterance.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return AssemblyAI::Realtime::ConfigureEndUtteranceSilenceThreshold.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        raise("Passed value matched no type within the union, validation failed.")
      end
    end
  end
end
