# frozen_string_literal: true

module AssemblyAI
  class Transcripts
    # Controls the filetype of the audio created by redact_pii_audio. Currently supports mp3 (default) and wav. See [PII redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more details.
    class RedactPiiAudioQuality
      MP3 = "mp3"
      WAV = "wav"
    end
  end
end
