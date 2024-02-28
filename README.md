<img src="https://github.com/AssemblyAI/assemblyai-node-sdk/blob/main/assemblyai.png?raw=true" width="500"/>

---

[![Gem Version](https://img.shields.io/gem/v/assemblyai)](https://rubygems.org/gems/assemblyai)
[![GitHub License](https://img.shields.io/github/license/AssemblyAI/assemblyai-ruby-sdk)](https://github.com/AssemblyAI/assemblyai-ruby-sdk/blob/main/LICENSE)
[![AssemblyAI Twitter](https://img.shields.io/twitter/follow/AssemblyAI?label=%40AssemblyAI&style=social)](https://twitter.com/AssemblyAI)
[![AssemblyAI YouTube](https://img.shields.io/youtube/channel/subscribers/UCtatfZMf-8EkIwASXM4ts0A)](https://www.youtube.com/@AssemblyAI)
[![Discord](https://img.shields.io/discord/875120158014853141?logo=discord&label=Discord&link=https%3A%2F%2Fdiscord.com%2Fchannels%2F875120158014853141&style=social)
](https://assemblyai.com/discord)

# AssemblyAI Ruby SDK

The AssemblyAI Ruby SDK provides an easy-to-use interface for interacting with the AssemblyAI API, which supports async, audio intelligence models, as well as the latest LeMUR models.
We're working on adding real-time transcription to the Ruby SDK.

# Documentation

Visit our [AssemblyAI API Documentation](https://www.assemblyai.com/docs) to get an overview of our models!

# Quick Start

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add assemblyai
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install assemblyai
```

## Usage
Import the AssemblyAI package and create an AssemblyAI object with your API key:

```ruby
require 'assemblyai'

client = AssemblyAI::Client.new(api_key: 'YOUR_API_KEY')
```
You can now use the `client` object to interact with the AssemblyAI API.

## Create a transcript

```ruby
transcript = client.transcripts.transcribe(
  audio_url: 'https://storage.googleapis.com/aai-web-samples/espn-bears.m4a',
)
```

`transcribe` queues a transcription job and polls it until the `status` is `completed` or `error`.
You can configure the polling interval and polling timeout using these options:

```ruby
transcript = client.transcripts.transcribe(
  audio_url: 'https://storage.googleapis.com/aai-web-samples/espn-bears.m4a',
  polling_options: AssemblyAI::Transcripts::PollingOptions.new(
    #  How frequently the transcript is polled in ms. Defaults to 3000.
    interval: 1000,
    #  How long to wait in ms until the 'Polling timeout' error is thrown. Defaults to infinite (-1).
    timeout: 5000
  )
)
```

If you don't want to wait until the transcript is ready, you can use `submit`:

```ruby
transcript = client.transcripts.submit(
  audio_url: 'https://storage.googleapis.com/aai-web-samples/espn-bears.m4a'
)
```

## Get a transcript

This will return the transcript object in its current state. If the transcript is still processing, the `status` field will be `queued` or `processing`. Once the transcript is complete, the `status` field will be `completed`.

```ruby
transcript = client.transcripts.get(transcript_id: transcript.id)
```

## List transcripts

This will return a page of transcripts you created.

```ruby
page = client.transcripts.list
```

You can also paginate over all pages.

```ruby
next_page_url = nil
loop do
  page = client.transcripts.list_by_url(url: next_page_url)
  next_page_url = page.page_details.next_url
  break if next_page_url.nil?
end
```

## Delete a transcript

```ruby
res = client.transcripts.delete(transcript_id: transcript.id)
```

## Use LeMUR

Call [LeMUR endpoints](https://www.assemblyai.com/docs/API%20reference/lemur) to summarize, ask questions, generate action items, or run a custom task.

Custom Summary:

```ruby
response = client.lemur.summary(
  transcript_ids: ['0d295578-8c75-421a-885a-2c487f188927'],
  answer_format: 'one sentence',
  context: {
    'speakers': ['Alex', 'Bob']
  }
)
```

Question & Answer:

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

Action Items:

```ruby
response = client.lemur.action_items(
  transcript_ids: ['0d295578-8c75-421a-885a-2c487f188927']
)
```

Custom Task:

```ruby
response = client.lemur.task(
  transcript_ids: ['0d295578-8c75-421a-885a-2c487f188927'],
  prompt: 'Write a haiku about this conversation.'
)
```
