# frozen_string_literal: true

module AssemblyAI
  class Transcripts
    # The replacement logic for detected PII, can be "entity_name" or "hash". See [PII
    #  redaction](https://www.assemblyai.com/docs/models/pii-redaction) for more
    #  details.
    class SubstitutionPolicy
      ENTITY_NAME = "entity_name"
      HASH = "hash"
    end
  end
end
