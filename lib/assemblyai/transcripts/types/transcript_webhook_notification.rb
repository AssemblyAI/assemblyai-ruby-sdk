# frozen_string_literal: true

require "json"
require_relative "transcript_ready_notification"
require_relative "redacted_audio_response"

module AssemblyAI
  class Transcripts
    # The notifications sent to the webhook URL.
    class TranscriptWebhookNotification
      # Deserialize a JSON object to an instance of TranscriptWebhookNotification
      #
      # @param json_object [String]
      # @return [AssemblyAI::Transcripts::TranscriptWebhookNotification]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        begin
          AssemblyAI::Transcripts::TranscriptReadyNotification.validate_raw(obj: struct)
          unless json_object.nil?
            return AssemblyAI::Transcripts::TranscriptReadyNotification.from_json(json_object: json_object)
          end

          return nil
        rescue StandardError
          # noop
        end
        begin
          AssemblyAI::Transcripts::RedactedAudioResponse.validate_raw(obj: struct)
          unless json_object.nil?
            return AssemblyAI::Transcripts::RedactedAudioResponse.from_json(json_object: json_object)
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
          return AssemblyAI::Transcripts::TranscriptReadyNotification.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return AssemblyAI::Transcripts::RedactedAudioResponse.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        raise("Passed value matched no type within the union, validation failed.")
      end
    end
  end
end
