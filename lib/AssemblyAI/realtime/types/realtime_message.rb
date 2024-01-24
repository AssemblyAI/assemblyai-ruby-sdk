# frozen_string_literal: true

require "json"
require_relative "session_begins"
require_relative "partial_transcript"
require_relative "final_transcript"
require_relative "session_terminated"
require_relative "realtime_error"

module AssemblyAI
  module Realtime
    class RealtimeMessage
      attr_reader :member
      alias kind_of? is_a?
      # @param member [Object]
      # @return [Realtime::RealtimeMessage]
      def initialize(member:)
        # @type [Object]
        @member = member
      end

      # Deserialize a JSON object to an instance of RealtimeMessage
      #
      # @param json_object [JSON]
      # @return [Realtime::RealtimeMessage]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        begin
          Realtime::SessionBegins.validate_raw(obj: struct)
          member = Realtime::SessionBegins.from_json(json_object: json_object)
          return new(member: member)
        rescue StandardError
          # noop
        end
        begin
          Realtime::PartialTranscript.validate_raw(obj: struct)
          member = Realtime::PartialTranscript.from_json(json_object: json_object)
          return new(member: member)
        rescue StandardError
          # noop
        end
        begin
          Realtime::FinalTranscript.validate_raw(obj: struct)
          member = Realtime::FinalTranscript.from_json(json_object: json_object)
          return new(member: member)
        rescue StandardError
          # noop
        end
        begin
          Realtime::SessionTerminated.validate_raw(obj: struct)
          member = Realtime::SessionTerminated.from_json(json_object: json_object)
          return new(member: member)
        rescue StandardError
          # noop
        end
        begin
          Realtime::RealtimeError.validate_raw(obj: struct)
          member = Realtime::RealtimeError.from_json(json_object: json_object)
          return new(member: member)
        rescue StandardError
          # noop
        end
        new(member: struct)
      end

      # For Union Types, to_json functionality is delegated to the wrapped member.
      #
      # @return [JSON]
      def to_json(*_args)
        @member.to_json
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

      # For Union Types, is_a? functionality is delegated to the wrapped member.
      #
      # @param obj [Object]
      # @return [Boolean]
      def is_a?(obj)
        @member.is_a?(obj)
      end
    end
  end
end
