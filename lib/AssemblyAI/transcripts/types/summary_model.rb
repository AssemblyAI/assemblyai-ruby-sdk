# frozen_string_literal: true

module AssemblyAI
  module Transcripts
    # @type [Hash{String => String}]
    SUMMARY_MODEL = { informative: "informative", conversational: "conversational", catchy: "catchy" }.frozen
  end
end
