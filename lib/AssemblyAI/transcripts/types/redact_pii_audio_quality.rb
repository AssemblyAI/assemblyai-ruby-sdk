# frozen_string_literal: true

module AssemblyAI
  module Transcripts
    # @type [Hash{String => String}]
    REDACT_PII_AUDIO_QUALITY = { mp_3: "mp3", wav: "wav" }.frozen
  end
end
