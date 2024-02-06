# frozen_string_literal: true

require_relative "test_helper"
require "assemblyai"

# Basic AssemblyAI tests
class TestAssemblyAI < Minitest::Test
  def test_transcription
    client = AssemblyAI::Client.new(api_key: "YOUR_API_KEY")

    transcript_submission = client.transcripts.submit(audio_url: "https://storage.googleapis.com/aai-web-samples/espn-bears.m4a")
    puts client.transcripts.get(transcript_id: transcript_submission.id)

    client.transcripts.list.transcripts.each do |transcript|
      puts transcript.to_json
    end
  end
end
