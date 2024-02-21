# frozen_string_literal: true

module AssemblyAI
  class Transcripts
    # Either success, or unavailable in the rare case that the model failed
    class AudioIntelligenceModelStatus
      SUCCESS = "success"
      UNAVAILABLE = "unavailable"
    end
  end
end
