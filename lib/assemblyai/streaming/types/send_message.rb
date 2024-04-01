# frozen_string_literal: true

require "json"
require_relative "../../realtime/types/terminate_session"
require_relative "../../realtime/types/force_end_utterance"
require_relative "../../realtime/types/configure_end_utterance_silence_threshold"

module AssemblyAI
  class Streaming
    # Send messages to the WebSocket
    class SendMessage
      # Deserialize a JSON object to an instance of SendMessage
      #
      # @param json_object [JSON]
      # @return [Streaming::SendMessage]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        begin
          struct.is_a?(String) != false || raise("Passed value for field struct is not the expected type, validation failed.")
          return json_object
        rescue StandardError
          # noop
        end
        begin
          Realtime::TerminateSession.validate_raw(obj: struct)
          return Realtime::TerminateSession.from_json(json_object: json_object)
        rescue StandardError
          # noop
        end
        begin
          Realtime::ForceEndUtterance.validate_raw(obj: struct)
          return Realtime::ForceEndUtterance.from_json(json_object: json_object)
        rescue StandardError
          # noop
        end
        begin
          Realtime::ConfigureEndUtteranceSilenceThreshold.validate_raw(obj: struct)
          return Realtime::ConfigureEndUtteranceSilenceThreshold.from_json(json_object: json_object)
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
          return obj.is_a?(String) != false || raise("Passed value for field obj is not the expected type, validation failed.")
        rescue StandardError
          # noop
        end
        begin
          return Realtime::TerminateSession.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return Realtime::ForceEndUtterance.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return Realtime::ConfigureEndUtteranceSilenceThreshold.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        raise("Passed value matched no type within the union, validation failed.")
      end
    end
  end
end
