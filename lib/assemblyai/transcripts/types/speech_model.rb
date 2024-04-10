# frozen_string_literal: true

module AssemblyAI
  class Transcripts
    # The speech model to use for the transcription.
    class SpeechModel
      BEST = "best"
      NANO = "nano"
      # @deprecated This option will stop working in the near future. Please use {#BEST} or {#NANO} instead
      CONFORMER2 = "conformer-2"
    end
  end
end
