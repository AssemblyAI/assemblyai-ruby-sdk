# frozen_string_literal: true

require_relative "test_helper"
require "async"

# Basic AssemblyAI tests
class TestAssemblyAI < Minitest::Test
  # @return [String] ASSEMBLYAI API key
  def api_key
    ENV.fetch("ASSEMBLYAI_API_KEY", nil)
  end

  def test_upload_file_with_file
    skip("Integration tests not enabled")
    client = AssemblyAI::Client.new(api_key: api_key)
    file = File.new("./test/gore-short.wav")
    uploaded_file = client.files.upload(file: file)
    assert !uploaded_file.upload_url.nil?
  end

  def test_upload_file_with_path
    skip("Integration tests not enabled")
    client = AssemblyAI::Client.new(api_key: api_key)
    uploaded_file = client.files.upload(file: "./test/gore-short.wav")
    assert !uploaded_file.upload_url.nil?
  end

  def test_upload_file_with_base64_string
    skip("Integration tests not enabled")
    client = AssemblyAI::Client.new(api_key: api_key)
    uploaded_file = client.files.upload(file: File.read("./test/gore-short.wav"))
    assert !uploaded_file.upload_url.nil?
  end

  def test_init
    # this test verifies that the SDK can be imported/initialized
    AssemblyAI::Client.new(api_key: "dummy")
  end

  def test_pagination
    skip("Integration tests not enabled")
    client = AssemblyAI::Client.new(api_key: api_key)
    transcript_list = client.transcripts.list

    count = 0
    client.transcripts.list.transcripts.each do |transcript|
      assert !transcript.id.nil?
      count += 1
    end
    assert count.positive?

    while transcript_list.page_details.next_url
      transcript_list = client.transcripts.list_by_url(url: transcript_list.page_details.next_url)

      count = 0
      client.transcripts.list.transcripts.each do |transcript|
        assert !transcript.id.nil?
        count += 1
      end
      assert count.positive?
    end
  end

  def test_transcribe
    # skip("Integration tests not enabled")
    client = AssemblyAI::Client.new(api_key: api_key)
    transcript = client.transcripts.transcribe(audio_url: "https://storage.googleapis.com/aai-web-samples/espn-bears.m4a")
    assert transcript.status == AssemblyAI::Transcripts::TranscriptStatus::COMPLETED
  end

  def test_submit
    skip("Integration tests not enabled")
    # Transcribe
    client = AssemblyAI::Client.new(api_key: api_key)

    transcript_submission = client.transcripts.submit(audio_url: "https://storage.googleapis.com/aai-web-samples/espn-bears.m4a")
    assert !transcript_submission.id.nil?
    gotten_transcript = client.transcripts.get(transcript_id: transcript_submission.id)
    assert gotten_transcript.id == transcript_submission.id
  end

  def test_polling
    # skip("Integration tests not enabled")
    client = AssemblyAI::Client.new(api_key: api_key)

    transcript = client.transcripts.submit(audio_url: "https://storage.googleapis.com/aai-web-samples/espn-bears.m4a")
    assert !transcript.id.nil?

    transcript = client.transcripts.wait_until_ready(transcript_id: transcript.id)
    assert transcript.status == AssemblyAI::Transcripts::TranscriptStatus::COMPLETED
  end

  def test_lemur
    skip("Integration tests not enabled")
    client = AssemblyAI::Client.new(api_key: api_key)
    assert !client.lemur.summary(transcript_ids: ["369849ed-b5a1-4add-9dde-ac936d3e7b99"]).response.nil?

    assert !client.lemur.question_answer(transcript_ids: ["369849ed-b5a1-4add-9dde-ac936d3e7b99"],
                                         questions: [{
                                           question: "What are they discussing?", answer_format: "text"
                                         }]).response.nil?

    lemur_task = client.lemur.task(transcript_ids: ["369849ed-b5a1-4add-9dde-ac936d3e7b99"],
                                   prompt: "Write a haiku about this conversation")
    assert !lemur_task.response.nil?

    lemur_task2 = client.lemur.get_response(request_id: lemur_task.request_id)

    assert Marshal.dump(lemur_task) == Marshal.dump(lemur_task2)
  end
end
