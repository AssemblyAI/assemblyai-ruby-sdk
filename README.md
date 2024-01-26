<img src="https://github.com/AssemblyAI/assemblyai-node-sdk/blob/main/assemblyai.png?raw=true" width="500"/>

---

[![Gem Version](https://img.shields.io/gem/v/assemblyai)](https://rubygems.org/gems/assemblyai)
[![GitHub License](https://img.shields.io/github/license/AssemblyAI/assemblyai-ruby-sdk)](https://github.com/AssemblyAI/assemblyai-ruby-sdk/blob/main/LICENSE)
[![AssemblyAI Twitter](https://img.shields.io/twitter/follow/AssemblyAI?label=%40AssemblyAI&style=social)](https://twitter.com/AssemblyAI)
[![AssemblyAI YouTube](https://img.shields.io/youtube/channel/subscribers/UCtatfZMf-8EkIwASXM4ts0A)](https://www.youtube.com/@AssemblyAI)
[![Discord](https://img.shields.io/discord/875120158014853141?logo=discord&label=Discord&link=https%3A%2F%2Fdiscord.com%2Fchannels%2F875120158014853141&style=social)
](https://assemblyai.com/discord)

# AssemblyAI Ruby SDK

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

### Serialization

```ruby
require "AssemblyAI/realtime/types/partial_transcript"

...
uri = URI(url)
response = Net::HTTP.get(uri)

partial_transcript = AssemblyAI::Realtime::PartialTranscript.from_json(json_object: response)
puts partial_transcript.message_type
```

### Deserialization

```ruby
require "AssemblyAI/realtime/types/partial_transcript"

...
partial_transcript = AssemblyAI::Realtime::PartialTranscript.from_json(json_object: response)

# All SDK objects natively support to_json calls for easy 
# serialization, even of highly nested objects.
response = Net::HTTP.post(uri, partial_transcript.to_json, headers)
```
