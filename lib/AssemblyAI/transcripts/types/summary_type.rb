# frozen_string_literal: true

module AssemblyAI
  module Transcripts
    # @type [Hash{String => String}]
    SUMMARY_TYPE = {
      bullets: "bullets",
      bullets_verbose: "bullets_verbose",
      gist: "gist",
      headline: "headline",
      paragraph: "paragraph"
    }.frozen
  end
end
