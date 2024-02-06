# frozen_string_literal: true

module AssemblyAI
  class Realtime
    # @type [MESSAGE_TYPE]
    MESSAGE_TYPE = {
      session_begins: "SessionBegins",
      partial_transcript: "PartialTranscript",
      final_transcript: "FinalTranscript",
      session_terminated: "SessionTerminated"
    }.freeze
  end
end
