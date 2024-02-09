# frozen_string_literal: true

require_relative "environment"
require_relative "types_export"
require_relative "requests"
require_relative "assemblyai/files/client"
require_relative "assemblyai/transcripts/client"
require_relative "assemblyai/transcripts/polling_client"
require_relative "assemblyai/realtime/client"
require_relative "assemblyai/lemur/client"

module AssemblyAI
  class Client
    attr_reader :files, :transcripts, :realtime, :lemur

    # @param environment [Environment]
    # @param max_retries [Long] The number of times to retry a failed request, defaults to 2.
    # @param timeout_in_seconds [Long]
    # @param api_key [String]
    # @return [Client]
    def initialize(api_key:, environment: Environment::DEFAULT, max_retries: nil, timeout_in_seconds: nil)
      @request_client = RequestClient.new(environment: environment, max_retries: max_retries,
                                          timeout_in_seconds: timeout_in_seconds, api_key: api_key)
      @files = FilesClient.new(request_client: @request_client)
      @transcripts = TranscriptsClient.new(request_client: @request_client)
      @realtime = RealtimeClient.new(request_client: @request_client)
      @lemur = LemurClient.new(request_client: @request_client)
    end
  end

  class AsyncClient
    attr_reader :files, :transcripts, :realtime, :lemur

    # @param environment [Environment]
    # @param max_retries [Long] The number of times to retry a failed request, defaults to 2.
    # @param timeout_in_seconds [Long]
    # @param api_key [String]
    # @return [AsyncClient]
    def initialize(api_key:, environment: Environment::DEFAULT, max_retries: nil, timeout_in_seconds: nil)
      @async_request_client = AsyncRequestClient.new(environment: environment, max_retries: max_retries,
                                                     timeout_in_seconds: timeout_in_seconds, api_key: api_key)
      @files = AsyncFilesClient.new(request_client: @async_request_client)
      @transcripts = AsyncTranscriptsClient.new(request_client: @async_request_client)
      @realtime = AsyncRealtimeClient.new(request_client: @async_request_client)
      @lemur = AsyncLemurClient.new(request_client: @async_request_client)
    end
  end
end
