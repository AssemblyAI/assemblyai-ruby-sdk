# frozen_string_literal: true

module AssemblyAI
  module Realtime
    # @type [Hash{String => String}]
    REALTIME_TRANSCRIPT_TYPE = { partial_transcript: "PartialTranscript", final_transcript: "FinalTranscript" }.frozen
  end
end
