# frozen_string_literal: true

module AssemblyAI
  class Lemur
    # @type [LEMUR_MODEL]
    LEMUR_MODEL = {
      default: "default",
      basic: "basic",
      assemblyai_mistral_7_b: "assemblyai/mistral-7b",
      anthropic_claude_21: "anthropic/claude-2-1"
    }.freeze
  end
end
