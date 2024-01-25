# frozen_string_literal: true

module AssemblyAI
  module Lemur
    # @type [Hash{String => String}]
    LEMUR_MODEL = {
      default: "default",
      basic: "basic",
      assemblyai_mistral_7_b: "assemblyai/mistral-7b",
      anthropic_claude_21: "anthropic/claude-2-1"
    }.frozen
  end
end
