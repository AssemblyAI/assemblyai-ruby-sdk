# frozen_string_literal: true

module AssemblyAI
    class Transcripts
      # Configuration options for polling requests.
      class PollingOptions
        attr_reader :interval, :timeout
  
        # @param interval [Integer] The amount of time to wait between polling requests, in milliseconds. Defaults to 3000.
        # @param timeout [Integer] The maximum amount of time to wait for the transcript to be ready, in milliseconds. Defaults to -1, which means poll forever.
        # @return [Transcripts::PollingOptions]
        def initialize(interval: 3000, timeout: -1)
          # @type [Integer] The amount of time to wait between polling requests, in milliseconds.
          @interval = interval
          # @type [Integer] The maximum amount of time to wait for the transcript to be ready, in milliseconds.
          @timeout = timeout
        end
      end
    end
  end
  