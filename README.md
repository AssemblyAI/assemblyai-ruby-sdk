<img src="https://github.com/AssemblyAI/assemblyai-node-sdk/blob/main/assemblyai.png?raw=true" width="500"/>

---

[![Gem Version](https://img.shields.io/gem/v/assemblyai)](https://rubygems.org/gems/assemblyai)
[![GitHub License](https://img.shields.io/github/license/AssemblyAI/assemblyai-ruby-sdk)](https://github.com/AssemblyAI/assemblyai-ruby-sdk/blob/main/LICENSE)
[![AssemblyAI Twitter](https://img.shields.io/twitter/follow/AssemblyAI?label=%40AssemblyAI&style=social)](https://twitter.com/AssemblyAI)
[![AssemblyAI YouTube](https://img.shields.io/youtube/channel/subscribers/UCtatfZMf-8EkIwASXM4ts0A)](https://www.youtube.com/@AssemblyAI)
[![Discord](https://img.shields.io/discord/875120158014853141?logo=discord&label=Discord&link=https%3A%2F%2Fdiscord.com%2Fchannels%2F875120158014853141&style=social)
](https://assembly.ai/discord)

# AssemblyAI Ruby SDK

The AssemblyAI Ruby SDK provides an easy-to-use interface for interacting with the AssemblyAI API, which supports async,
audio intelligence models, as well as the latest LeMUR models.

The Ruby SDK does not support Streaming STT at this time.

## Documentation

Visit the [AssemblyAI documentation](https://www.assemblyai.com/docs) for step-by-step instructions and a lot more details about our AI models and API.

## Quickstart

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add assemblyai
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install assemblyai
```

Import the AssemblyAI package and create an AssemblyAI object with your API key:

```ruby
require 'assemblyai'

client = AssemblyAI::Client.new(api_key: 'YOUR_API_KEY')
```

You can now use the `client` object to interact with the AssemblyAI API.

## Speech-To-Text
<details open>
  <summary>Transcribe an audio file with a public URL</summary>

```ruby
transcript = client.transcripts.transcribe(
  audio_url: 'https://assembly.ai/espn.m4a',
)
```

`transcribe` queues a transcription job and polls it until the `status` is `completed` or `error`.

If you don't want to wait until the transcript is ready, you can use `submit`:

```ruby
transcript = client.transcripts.submit(
  audio_url: 'https://assembly.ai/espn.m4a'
)
```

</details>
<details>
  <summary>Transcribe a local audio file</summary>

```ruby
uploaded_file = client.files.upload(file: '/path/to/your/file')
# You can also pass an IO object or base64 string
# uploaded_file = client.files.upload(file: File.new('/path/to/your/file'))

transcript = client.transcripts.transcribe(audio_url: uploaded_file.upload_url)
puts transcript.text
```

`transcribe` queues a transcription job and polls it until the `status` is `completed` or `error`.

If you don't want to wait until the transcript is ready, you can use `submit`:

```ruby
transcript = client.transcripts.submit(audio_url: uploaded_file.upload_url)
```

</details>

<details>
  <summary>Enable additional AI models</summary>

You can extract even more insights from the audio by enabling any of
our [AI models](https://www.assemblyai.com/docs/audio-intelligence) using _transcription options_.
For example, here's how to
enable [Speaker diarization](https://www.assemblyai.com/docs/speech-to-text/speaker-diarization) model to detect who
said what.

```ruby
transcript = client.transcripts.transcribe(
  audio_url: audio_url,
  speaker_labels: true
)

transcript.utterances.each do |utterance|
  printf('Speaker %<speaker>s: %<text>s', speaker: utterance.speaker, text: utterance.text)
end
```

</details>

<details>
  <summary>Get a transcript</summary>

This will return the transcript object in its current state. If the transcript is still processing, the `status` field
will be `queued` or `processing`. Once the transcript is complete, the `status` field will be `completed`.

```ruby
transcript = client.transcripts.get(transcript_id: transcript.id)
```

</details>

<details>
  <summary>Get sentences and paragraphs</summary>

```ruby
sentences = client.transcripts.get_sentences(transcript_id: transcript.id)
p sentences

paragraphs = client.transcripts.get_paragraphs(transcript_id: transcript.id)
p paragraphs
```

</details>

<details>
  <summary>Get subtitles</summary>

```ruby
srt = client.transcripts.get_subtitles(
  transcript_id: transcript.id,
  subtitle_format: AssemblyAI::Transcripts::SubtitleFormat::SRT
)
srt = client.transcripts.get_subtitles(
  transcript_id: transcript.id,
  subtitle_format: AssemblyAI::Transcripts::SubtitleFormat::SRT,
  chars_per_caption: 32
)

vtt = client.transcripts.get_subtitles(
  transcript_id: transcript.id,
  subtitle_format: AssemblyAI::Transcripts::SubtitleFormat::VTT
)
vtt = client.transcripts.get_subtitles(
  transcript_id: transcript.id,
  subtitle_format: AssemblyAI::Transcripts::SubtitleFormat::VTT,
  chars_per_caption: 32
)
```

</details>

<details>
<summary>List transcripts</summary>
This will return a page of transcripts you created.

```ruby
page = client.transcripts.list
```

You can pass parameters to `.list` to filter the transcripts.
To paginate over all pages, subsequently, use the `.list_by_url` method.

```ruby
loop do
  page = client.transcripts.list_by_url(url: page.page_details.prev_url)
  break if page.page_details.prev_url.nil?
end
```

</details>

<details>
<summary>Delete a transcript</summary>

```ruby
response = client.transcripts.delete(transcript_id: transcript.id)
```

</details>

## Apply LLMs to your audio with LeMUR

Call [LeMUR endpoints](https://www.assemblyai.com/docs/api-reference/lemur) to apply LLMs to your transcript.

<details open>
<summary>Prompt your audio with LeMUR</summary>

```ruby
response = client.lemur.task(
  transcript_ids: ['0d295578-8c75-421a-885a-2c487f188927'],
  prompt: 'Write a haiku about this conversation.'
)
```

</details>

<details>
<summary>Summarize with LeMUR</summary>

```ruby
response = client.lemur.summary(
  transcript_ids: ['0d295578-8c75-421a-885a-2c487f188927'],
  answer_format: 'one sentence',
  context: {
    'speakers': ['Alex', 'Bob']
  }
)
```

</details>

<details>
<summary>Ask questions</summary>

```ruby
response = client.lemur.question_answer(
  transcript_ids: ['0d295578-8c75-421a-885a-2c487f188927'],
  questions: [
    {
      question: 'What are they discussing?',
      answer_format: 'text'
    }
  ]
)
```

</details>
<details>
<summary>Generate action items</summary>

```ruby
response = client.lemur.action_items(
  transcript_ids: ['0d295578-8c75-421a-885a-2c487f188927']
)
```

</details>
<details>
<summary>Delete LeMUR request</summary>

```ruby
response = client.lemur.task(...)
deletion_response = client.lemur.purge_request_data(request_id: response.request_id)
```

</details>
