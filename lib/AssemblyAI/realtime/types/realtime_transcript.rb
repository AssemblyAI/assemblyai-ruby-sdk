# frozen_string_literal: true

require "json"
require_relative "partial_transcript"
require_relative "final_transcript"

module AssemblyAI
  module Realtime
    class RealtimeTranscript
      attr_reader :member
      alias kind_of? is_a?
      # @param member [Object]
      # @return [Realtime::RealtimeTranscript]
      def initialize(member:)
        # @type [Object]
        @member = member
      end

      # Deserialize a JSON object to an instance of RealtimeTranscript
      #
      # @param json_object [JSON]
      # @return [Realtime::RealtimeTranscript]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
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
          return Realtime::PartialTranscript.validate_raw(obj: obj)
        rescue StandardError
          # noop
        end
        begin
          return Realtime::FinalTranscript.validate_raw(obj: obj)
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
