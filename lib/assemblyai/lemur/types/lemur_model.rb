# frozen_string_literal: true

module AssemblyAI
  class Lemur
    # The model that is used for the final prompt after compression is performed.
    class LemurModel
      ANTHROPIC_CLAUDE3_5_SONNET = "anthropic/claude-3-5-sonnet"
      ANTHROPIC_CLAUDE3_OPUS = "anthropic/claude-3-opus"
      ANTHROPIC_CLAUDE3_HAIKU = "anthropic/claude-3-haiku"
      ANTHROPIC_CLAUDE3_SONNET = "anthropic/claude-3-sonnet"
      ANTHROPIC_CLAUDE2_1 = "anthropic/claude-2-1"
      ANTHROPIC_CLAUDE2 = "anthropic/claude-2"
      DEFAULT = "default"
      ANTHROPIC_CLAUDE_INSTANT1_2 = "anthropic/claude-instant-1-2"
      BASIC = "basic"
      ASSEMBLYAI_MISTRAL7B = "assemblyai/mistral-7b"
    end
  end
end
