# frozen_string_literal: true

module AssemblyAI
  module Realtime
    # @type [Hash{String => String}]
    AUDIO_ENCODING = { pcm_s_16_le: "pcm_s16le", pcm_mulaw: "pcm_mulaw" }.frozen
  end
end
