# frozen_string_literal: true

module AssemblyAI
  class Lemur
    # The model that is used for the final prompt after compression is performed.
    class LemurModel
      DEFAULT = "default"
      BASIC = "basic"
      ASSEMBLYAI_MISTRAL7B = "assemblyai/mistral-7b"
      ANTHROPIC_CLAUDE2_1 = "anthropic/claude-2-1"
    end
  end
end
