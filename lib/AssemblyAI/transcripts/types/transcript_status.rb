# frozen_string_literal: true

module AssemblyAI
  module Transcripts
    # @type [Hash{String => String}]
    TRANSCRIPT_STATUS = { queued: "queued", processing: "processing", completed: "completed", error: "error" }.frozen
  end
end
