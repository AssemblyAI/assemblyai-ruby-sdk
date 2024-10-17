# frozen_string_literal: true

require_relative "test_helper"
require "async"
require "dotenv/load"

# Basic AssemblyAI tests
class TestAssemblyAI < Minitest::Test
  # @return [String] AssemblyAI API key
  def api_key
    ENV.fetch("ASSEMBLYAI_API_KEY")
  end

  # @return [String] AssemblyAI Base URL
  def base_url
    ENV.key?("ASSEMBLYAI_BASE_URL") ? ENV.fetch("ASSEMBLYAI_BASE_URL") : AssemblyAI::Environment::DEFAULT
  end

  def client
    AssemblyAI::Client.new(
      api_key: api_key,
      environment: base_url
    )
  end

  # @return [String] Transcript ID
  def transcript_id
    ENV.fetch("TEST_TRANSCRIPT_ID")
  end

  # @return [Array<String>] Transcript IDs
  def transcript_ids
    ENV.fetch("TEST_TRANSCRIPT_IDS").split(",")
  end

  def test_upload_file_with_file
    file = File.new("./test/gore-short.wav")
    uploaded_file = client.files.upload(file: file)
    assert !uploaded_file.upload_url.nil?
  end

  def test_upload_file_with_path
    uploaded_file = client.files.upload(file: "./test/gore-short.wav")
    assert !uploaded_file.upload_url.nil?
  end

  def test_upload_file_with_base64_string
    uploaded_file = client.files.upload(file: File.read("./test/gore-short.wav"))
    assert !uploaded_file.upload_url.nil?
  end

  def test_init
    # this test verifies that the SDK can be imported/initialized
    AssemblyAI::Client.new(api_key: "dummy")
  end

  def test_pagination
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
    transcript = client.transcripts.transcribe(audio_url: "https://assembly.ai/espn.m4a")
    assert transcript.status == AssemblyAI::Transcripts::TranscriptStatus::COMPLETED
  end

  def test_submit
    # Transcribe
    transcript_submission = client.transcripts.submit(audio_url: "https://assembly.ai/espn.m4a")
    assert !transcript_submission.id.nil?
    gotten_transcript = client.transcripts.get(transcript_id: transcript_submission.id)
    assert gotten_transcript.id == transcript_submission.id
  end

  def test_polling
    transcript = client.transcripts.submit(audio_url: "https://assembly.ai/espn.m4a")
    assert !transcript.id.nil?

    transcript = client.transcripts.wait_until_ready(transcript_id: transcript.id)
    assert transcript.status == AssemblyAI::Transcripts::TranscriptStatus::COMPLETED
  end

  def test_lemur
    assert !client.lemur.summary(transcript_ids: transcript_ids).response.nil?

    qa_response = client.lemur.question_answer(
      transcript_ids: transcript_ids,
      questions: [{
        question: "What are they discussing?", answer_format: "text"
      }]
    )
    assert !qa_response.response.nil?

    qa_response2 = client.lemur.get_response(request_id: qa_response.request_id)

    assert qa_response.to_json == qa_response2.to_json

    lemur_task = client.lemur.task(
      transcript_ids: transcript_ids,
      prompt: "Write a haiku about this conversation"
    )
    assert !lemur_task.response.nil?

    lemur_task2 = client.lemur.get_response(request_id: lemur_task.request_id)

    assert lemur_task.to_json == lemur_task2.to_json
  end

  def test_transcribe_multichannel_audio
    transcript = client.transcripts.transcribe(
      audio_url: "https://assemblyai-test.s3.us-west-2.amazonaws.com/e2e_tests/en_7dot1_audio_channels.wav",
      multichannel: true
    )

    expected_output = %w[One. Two. Three. Four. Five. Six. Seven. Eight.]

    assert_equal true, transcript.multichannel
    assert_equal expected_output.length, transcript.words.length
    assert_equal expected_output.length, transcript.utterances.length

    words = transcript.words
    utterances = transcript.utterances

    expected_output.each_with_index do |expected_word, i|
      channel_string = (i + 1).to_s

      assert_equal expected_word, words[i].text
      assert_equal channel_string, words[i].speaker
      assert_equal channel_string, words[i].channel

      assert_equal expected_word, utterances[i].text
      assert_equal channel_string, utterances[i].speaker
      assert_equal channel_string, utterances[i].channel
      assert_equal 1, utterances[i].words.length
      assert_equal expected_word, utterances[i].words[0].text
      assert_equal channel_string, utterances[i].words[0].speaker
      assert_equal channel_string, utterances[i].words[0].channel
    end
  end
end
