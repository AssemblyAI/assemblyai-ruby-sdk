# AssemblyAI Ruby Library
> _Build with AI models that can transcribe and understand audio_

With a single API call, get access to AI models built on the latest AI breakthroughs to transcribe and understand audio and speech data securely at large scale.

# Documentation

Visit our [AssemblyAI API Documentation](https://www.assemblyai.com/docs) to get an overview of our models!

# Quick Start

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash

    $ bundle add assemblyai_ruby
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
    $ gem install assemblyai_ruby
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
