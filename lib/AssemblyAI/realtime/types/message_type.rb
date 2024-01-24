# frozen_string_literal: true

module AssemblyAI
  module Realtime
    # @type [Hash{String => String}]
    MESSAGE_TYPE = {
      session_begins: "SessionBegins",
      partial_transcript: "PartialTranscript",
      final_transcript: "FinalTranscript",
      session_terminated: "SessionTerminated"
    }.frozen
  end
end
