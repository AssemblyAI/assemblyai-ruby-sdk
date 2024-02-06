# frozen_string_literal: true

module AssemblyAI
  class Transcripts
    # @type [TRANSCRIPT_STATUS]
    TRANSCRIPT_STATUS = { queued: "queued", processing: "processing", completed: "completed", error: "error" }.freeze
  end
end
