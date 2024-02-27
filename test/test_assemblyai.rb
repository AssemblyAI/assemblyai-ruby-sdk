# frozen_string_literal: true

require_relative "test_helper"
require "async"

# Basic AssemblyAI tests
class TestAssemblyAI < Minitest::Test
  def test_polling
    client = AssemblyAI::Client.new(api_key: "YOUR_API_KEY")
    transcript = client.transcripts.transcribe(audio_url: "https://storage.googleapis.com/aai-web-samples/espn-bears.m4a")
    assert transcript.status == AssemblyAI::Transcripts::TranscriptStatus::COMPLETED

    client = AssemblyAI::AsyncClient.new(api_key: "YOUR_API_KEY")
    Sync do
      transcript_task = client.transcripts.transcribe(audio_url: "https://storage.googleapis.com/aai-web-samples/espn-bears.m4a")
      assert transcript_task.is_a? Async::Task
      transcript = transcript_task.wait
      puts transcript.status
      assert transcript.status == AssemblyAI::Transcripts::TranscriptStatus::COMPLETED
    end
  end

  def test_transcribe
    # Transcribe
    client = AssemblyAI::Client.new(api_key: "YOUR_API_KEY")

    transcript_submission = client.transcripts.submit(audio_url: "https://storage.googleapis.com/aai-web-samples/espn-bears.m4a")
    assert !transcript_submission.id.nil?
    gotten_transcript = client.transcripts.get(transcript_id: transcript_submission.id)
    assert gotten_transcript.id == transcript_submission.id

    count = 0
    client.transcripts.list.transcripts.each do |transcript|
      assert !transcript.id.nil?
      count += 1
    end
    assert count.positive?
  end

  def test_lemur
    client = AssemblyAI::Client.new(api_key: "YOUR_API_KEY")
    assert !client.lemur.summary(transcript_ids: ["369849ed-b5a1-4add-9dde-ac936d3e7b99"]).response.nil?

    assert !client.lemur.question_answer(transcript_ids: ["369849ed-b5a1-4add-9dde-ac936d3e7b99"], questions: [{question: "What are they discussing?", answer_format: "text"}]).response.nil?

    assert !client.lemur.task(transcript_ids: ["369849ed-b5a1-4add-9dde-ac936d3e7b99"], prompt: "Write a haiku about this conversation").response.nil?
  end
end
