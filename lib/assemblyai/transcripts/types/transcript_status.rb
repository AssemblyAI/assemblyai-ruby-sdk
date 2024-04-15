# frozen_string_literal: true

module AssemblyAI
  class Transcripts
    # The status of your transcript. Possible values are queued, processing,
    #  completed, or error.
    class TranscriptStatus
      QUEUED = "queued"
      PROCESSING = "processing"
      COMPLETED = "completed"
      ERROR = "error"
    end
  end
end
