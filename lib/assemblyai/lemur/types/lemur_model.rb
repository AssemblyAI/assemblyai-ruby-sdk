# frozen_string_literal: true

module AssemblyAI
  class Lemur
    # @type [LEMUR_MODEL]
    LEMUR_MODEL = {
      default: "default",
      basic: "basic",
      assemblyai_mistral7b: "assemblyai/mistral-7b",
      anthropic_claude2_1: "anthropic/claude-2-1"
    }.freeze
  end
end
