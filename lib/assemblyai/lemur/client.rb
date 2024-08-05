# frozen_string_literal: true

require_relative "../../requests"
require_relative "types/lemur_base_params_context"
require_relative "types/lemur_model"
require "ostruct"
require_relative "types/lemur_task_response"
require_relative "types/lemur_summary_response"
require_relative "types/lemur_question"
require_relative "types/lemur_question_answer_response"
require_relative "types/lemur_action_items_response"
require_relative "types/lemur_response"
require_relative "types/purge_lemur_request_data_response"
require "async"

module AssemblyAI
  class LemurClient
    # @return [AssemblyAI::RequestClient]
    attr_reader :request_client

    # @param request_client [AssemblyAI::RequestClient]
    # @return [AssemblyAI::LemurClient]
    def initialize(request_client:)
      @request_client = request_client
    end

    # Use the LeMUR task endpoint to input your own LLM prompt.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100
    #  hours, whichever is lower.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the
    #  selected model, which defaults to 100000.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param context [String, Hash{String => Object}] Context to provide the model. This can be a string or a free-form JSON value.
    # @param final_model [AssemblyAI::Lemur::LemurModel] The model that is used for the final prompt after compression is performed.
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #  Higher values result in answers that are more creative, lower values are more
    #  conservative.
    #  Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param _field_set [Object]
    # @param prompt [String] Your text to prompt the model to produce a desired output, including any context
    #  you want to pass into the model.
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::LemurTaskResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.task(prompt: "List all the locations affected by wildfires.")
    def task(prompt:, transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
             temperature: nil, additional_properties: nil, _field_set: nil, request_options: nil)
      response = @request_client.conn.post do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = {
      **(req.headers || {}),
      **@request_client.get_headers,
      **(request_options&.additional_headers || {})
        }.compact
        unless request_options.nil? || request_options&.additional_query_parameters.nil?
          req.params = { **(request_options&.additional_query_parameters || {}) }.compact
        end
        req.body = {
          **(request_options&.additional_body_parameters || {}),
          transcript_ids: transcript_ids,
          input_text: input_text,
          context: context,
          final_model: final_model,
          max_output_size: max_output_size,
          temperature: temperature,
          additional_properties: additional_properties,
          _field_set: _field_set,
          prompt: prompt
        }.compact
        req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/generate/task"
      end
      AssemblyAI::Lemur::LemurTaskResponse.from_json(json_object: response.body)
    end

    # Custom Summary allows you to distill a piece of audio into a few impactful
    #  sentences.
    #  You can give the model context to obtain more targeted results while outputting
    #  the results in a variety of formats described in human language.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100
    #  hours, whichever is lower.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the
    #  selected model, which defaults to 100000.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param context [String, Hash{String => Object}] Context to provide the model. This can be a string or a free-form JSON value.
    # @param final_model [AssemblyAI::Lemur::LemurModel] The model that is used for the final prompt after compression is performed.
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #  Higher values result in answers that are more creative, lower values are more
    #  conservative.
    #  Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param _field_set [Object]
    # @param answer_format [String] How you want the summary to be returned. This can be any text. Examples: "TLDR",
    #  "bullet points"
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::LemurSummaryResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.summary
    def summary(transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                temperature: nil, additional_properties: nil, _field_set: nil, answer_format: nil, request_options: nil)
      response = @request_client.conn.post do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = {
      **(req.headers || {}),
      **@request_client.get_headers,
      **(request_options&.additional_headers || {})
        }.compact
        unless request_options.nil? || request_options&.additional_query_parameters.nil?
          req.params = { **(request_options&.additional_query_parameters || {}) }.compact
        end
        req.body = {
          **(request_options&.additional_body_parameters || {}),
          transcript_ids: transcript_ids,
          input_text: input_text,
          context: context,
          final_model: final_model,
          max_output_size: max_output_size,
          temperature: temperature,
          additional_properties: additional_properties,
          _field_set: _field_set,
          answer_format: answer_format
        }.compact
        req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/generate/summary"
      end
      AssemblyAI::Lemur::LemurSummaryResponse.from_json(json_object: response.body)
    end

    # Question & Answer allows you to ask free-form questions about a single
    #  transcript or a group of transcripts.
    #  The questions can be any whose answers you find useful, such as judging whether
    #  a caller is likely to become a customer or whether all items on a meeting's
    #  agenda were covered.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100
    #  hours, whichever is lower.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the
    #  selected model, which defaults to 100000.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param context [String, Hash{String => Object}] Context to provide the model. This can be a string or a free-form JSON value.
    # @param final_model [AssemblyAI::Lemur::LemurModel] The model that is used for the final prompt after compression is performed.
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #  Higher values result in answers that are more creative, lower values are more
    #  conservative.
    #  Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param _field_set [Object]
    # @param questions [Array<Hash>] A list of questions to askRequest of type Array<AssemblyAI::Lemur::LemurQuestion>, as a Hash
    #   * :question (String)
    #   * :context (Hash)
    #   * :answer_format (String)
    #   * :answer_options (Array<String>)
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::LemurQuestionAnswerResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.question_answer(questions: [{ question: "Where are there wildfires?", answer_format: "List of countries in ISO 3166-1 alpha-2 format", answer_options: ["US", "CA"] }, { question: "Is global warming affecting wildfires?", answer_options: ["yes", "no"] }])
    def question_answer(questions:, transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                        temperature: nil, additional_properties: nil, _field_set: nil, request_options: nil)
      response = @request_client.conn.post do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = {
      **(req.headers || {}),
      **@request_client.get_headers,
      **(request_options&.additional_headers || {})
        }.compact
        unless request_options.nil? || request_options&.additional_query_parameters.nil?
          req.params = { **(request_options&.additional_query_parameters || {}) }.compact
        end
        req.body = {
          **(request_options&.additional_body_parameters || {}),
          transcript_ids: transcript_ids,
          input_text: input_text,
          context: context,
          final_model: final_model,
          max_output_size: max_output_size,
          temperature: temperature,
          additional_properties: additional_properties,
          _field_set: _field_set,
          questions: questions
        }.compact
        req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/generate/question-answer"
      end
      AssemblyAI::Lemur::LemurQuestionAnswerResponse.from_json(json_object: response.body)
    end

    # Use LeMUR to generate a list of action items from a transcript
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100
    #  hours, whichever is lower.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the
    #  selected model, which defaults to 100000.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param context [String, Hash{String => Object}] Context to provide the model. This can be a string or a free-form JSON value.
    # @param final_model [AssemblyAI::Lemur::LemurModel] The model that is used for the final prompt after compression is performed.
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #  Higher values result in answers that are more creative, lower values are more
    #  conservative.
    #  Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param _field_set [Object]
    # @param answer_format [String] How you want the action items to be returned. This can be any text.
    #  Defaults to "Bullet Points".
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::LemurActionItemsResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.action_items(answer_format: "Bullet Points")
    def action_items(transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                     temperature: nil, additional_properties: nil, _field_set: nil, answer_format: nil, request_options: nil)
      response = @request_client.conn.post do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = {
      **(req.headers || {}),
      **@request_client.get_headers,
      **(request_options&.additional_headers || {})
        }.compact
        unless request_options.nil? || request_options&.additional_query_parameters.nil?
          req.params = { **(request_options&.additional_query_parameters || {}) }.compact
        end
        req.body = {
          **(request_options&.additional_body_parameters || {}),
          transcript_ids: transcript_ids,
          input_text: input_text,
          context: context,
          final_model: final_model,
          max_output_size: max_output_size,
          temperature: temperature,
          additional_properties: additional_properties,
          _field_set: _field_set,
          answer_format: answer_format
        }.compact
        req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/generate/action-items"
      end
      AssemblyAI::Lemur::LemurActionItemsResponse.from_json(json_object: response.body)
    end

    # Retrieve a LeMUR response that was previously generated.
    #
    # @param request_id [String] The ID of the LeMUR request you previously made.
    #  This would be found in the response of the original request.
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::LemurStringResponse, AssemblyAI::Lemur::LemurQuestionAnswerResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.get_response(request_id: "request_id")
    def get_response(request_id:, request_options: nil)
      response = @request_client.conn.get do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = {
      **(req.headers || {}),
      **@request_client.get_headers,
      **(request_options&.additional_headers || {})
        }.compact
        unless request_options.nil? || request_options&.additional_query_parameters.nil?
          req.params = { **(request_options&.additional_query_parameters || {}) }.compact
        end
        unless request_options.nil? || request_options&.additional_body_parameters.nil?
          req.body = { **(request_options&.additional_body_parameters || {}) }.compact
        end
        req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/#{request_id}"
      end
      AssemblyAI::Lemur::LemurResponse.from_json(json_object: response.body)
    end

    # Delete the data for a previously submitted LeMUR request.
    #  The LLM response data, as well as any context provided in the original request
    #  will be removed.
    #
    # @param request_id [String] The ID of the LeMUR request whose data you want to delete. This would be found
    #  in the response of the original request.
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::PurgeLemurRequestDataResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.purge_request_data(request_id: "request_id")
    def purge_request_data(request_id:, request_options: nil)
      response = @request_client.conn.delete do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = {
      **(req.headers || {}),
      **@request_client.get_headers,
      **(request_options&.additional_headers || {})
        }.compact
        unless request_options.nil? || request_options&.additional_query_parameters.nil?
          req.params = { **(request_options&.additional_query_parameters || {}) }.compact
        end
        unless request_options.nil? || request_options&.additional_body_parameters.nil?
          req.body = { **(request_options&.additional_body_parameters || {}) }.compact
        end
        req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/#{request_id}"
      end
      AssemblyAI::Lemur::PurgeLemurRequestDataResponse.from_json(json_object: response.body)
    end
  end

  class AsyncLemurClient
    # @return [AssemblyAI::AsyncRequestClient]
    attr_reader :request_client

    # @param request_client [AssemblyAI::AsyncRequestClient]
    # @return [AssemblyAI::AsyncLemurClient]
    def initialize(request_client:)
      @request_client = request_client
    end

    # Use the LeMUR task endpoint to input your own LLM prompt.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100
    #  hours, whichever is lower.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the
    #  selected model, which defaults to 100000.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param context [String, Hash{String => Object}] Context to provide the model. This can be a string or a free-form JSON value.
    # @param final_model [AssemblyAI::Lemur::LemurModel] The model that is used for the final prompt after compression is performed.
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #  Higher values result in answers that are more creative, lower values are more
    #  conservative.
    #  Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param _field_set [Object]
    # @param prompt [String] Your text to prompt the model to produce a desired output, including any context
    #  you want to pass into the model.
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::LemurTaskResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.task(prompt: "List all the locations affected by wildfires.")
    def task(prompt:, transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
             temperature: nil, additional_properties: nil, _field_set: nil, request_options: nil)
      Async do
        response = @request_client.conn.post do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = {
        **(req.headers || {}),
        **@request_client.get_headers,
        **(request_options&.additional_headers || {})
          }.compact
          unless request_options.nil? || request_options&.additional_query_parameters.nil?
            req.params = { **(request_options&.additional_query_parameters || {}) }.compact
          end
          req.body = {
            **(request_options&.additional_body_parameters || {}),
            transcript_ids: transcript_ids,
            input_text: input_text,
            context: context,
            final_model: final_model,
            max_output_size: max_output_size,
            temperature: temperature,
            additional_properties: additional_properties,
            _field_set: _field_set,
            prompt: prompt
          }.compact
          req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/generate/task"
        end
        AssemblyAI::Lemur::LemurTaskResponse.from_json(json_object: response.body)
      end
    end

    # Custom Summary allows you to distill a piece of audio into a few impactful
    #  sentences.
    #  You can give the model context to obtain more targeted results while outputting
    #  the results in a variety of formats described in human language.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100
    #  hours, whichever is lower.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the
    #  selected model, which defaults to 100000.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param context [String, Hash{String => Object}] Context to provide the model. This can be a string or a free-form JSON value.
    # @param final_model [AssemblyAI::Lemur::LemurModel] The model that is used for the final prompt after compression is performed.
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #  Higher values result in answers that are more creative, lower values are more
    #  conservative.
    #  Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param _field_set [Object]
    # @param answer_format [String] How you want the summary to be returned. This can be any text. Examples: "TLDR",
    #  "bullet points"
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::LemurSummaryResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.summary
    def summary(transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                temperature: nil, additional_properties: nil, _field_set: nil, answer_format: nil, request_options: nil)
      Async do
        response = @request_client.conn.post do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = {
        **(req.headers || {}),
        **@request_client.get_headers,
        **(request_options&.additional_headers || {})
          }.compact
          unless request_options.nil? || request_options&.additional_query_parameters.nil?
            req.params = { **(request_options&.additional_query_parameters || {}) }.compact
          end
          req.body = {
            **(request_options&.additional_body_parameters || {}),
            transcript_ids: transcript_ids,
            input_text: input_text,
            context: context,
            final_model: final_model,
            max_output_size: max_output_size,
            temperature: temperature,
            additional_properties: additional_properties,
            _field_set: _field_set,
            answer_format: answer_format
          }.compact
          req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/generate/summary"
        end
        AssemblyAI::Lemur::LemurSummaryResponse.from_json(json_object: response.body)
      end
    end

    # Question & Answer allows you to ask free-form questions about a single
    #  transcript or a group of transcripts.
    #  The questions can be any whose answers you find useful, such as judging whether
    #  a caller is likely to become a customer or whether all items on a meeting's
    #  agenda were covered.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100
    #  hours, whichever is lower.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the
    #  selected model, which defaults to 100000.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param context [String, Hash{String => Object}] Context to provide the model. This can be a string or a free-form JSON value.
    # @param final_model [AssemblyAI::Lemur::LemurModel] The model that is used for the final prompt after compression is performed.
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #  Higher values result in answers that are more creative, lower values are more
    #  conservative.
    #  Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param _field_set [Object]
    # @param questions [Array<Hash>] A list of questions to askRequest of type Array<AssemblyAI::Lemur::LemurQuestion>, as a Hash
    #   * :question (String)
    #   * :context (Hash)
    #   * :answer_format (String)
    #   * :answer_options (Array<String>)
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::LemurQuestionAnswerResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.question_answer(questions: [{ question: "Where are there wildfires?", answer_format: "List of countries in ISO 3166-1 alpha-2 format", answer_options: ["US", "CA"] }, { question: "Is global warming affecting wildfires?", answer_options: ["yes", "no"] }])
    def question_answer(questions:, transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                        temperature: nil, additional_properties: nil, _field_set: nil, request_options: nil)
      Async do
        response = @request_client.conn.post do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = {
        **(req.headers || {}),
        **@request_client.get_headers,
        **(request_options&.additional_headers || {})
          }.compact
          unless request_options.nil? || request_options&.additional_query_parameters.nil?
            req.params = { **(request_options&.additional_query_parameters || {}) }.compact
          end
          req.body = {
            **(request_options&.additional_body_parameters || {}),
            transcript_ids: transcript_ids,
            input_text: input_text,
            context: context,
            final_model: final_model,
            max_output_size: max_output_size,
            temperature: temperature,
            additional_properties: additional_properties,
            _field_set: _field_set,
            questions: questions
          }.compact
          req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/generate/question-answer"
        end
        AssemblyAI::Lemur::LemurQuestionAnswerResponse.from_json(json_object: response.body)
      end
    end

    # Use LeMUR to generate a list of action items from a transcript
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100
    #  hours, whichever is lower.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the
    #  selected model, which defaults to 100000.
    #  Use either transcript_ids or input_text as input into LeMUR.
    # @param context [String, Hash{String => Object}] Context to provide the model. This can be a string or a free-form JSON value.
    # @param final_model [AssemblyAI::Lemur::LemurModel] The model that is used for the final prompt after compression is performed.
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #  Higher values result in answers that are more creative, lower values are more
    #  conservative.
    #  Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param _field_set [Object]
    # @param answer_format [String] How you want the action items to be returned. This can be any text.
    #  Defaults to "Bullet Points".
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::LemurActionItemsResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.action_items(answer_format: "Bullet Points")
    def action_items(transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                     temperature: nil, additional_properties: nil, _field_set: nil, answer_format: nil, request_options: nil)
      Async do
        response = @request_client.conn.post do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = {
        **(req.headers || {}),
        **@request_client.get_headers,
        **(request_options&.additional_headers || {})
          }.compact
          unless request_options.nil? || request_options&.additional_query_parameters.nil?
            req.params = { **(request_options&.additional_query_parameters || {}) }.compact
          end
          req.body = {
            **(request_options&.additional_body_parameters || {}),
            transcript_ids: transcript_ids,
            input_text: input_text,
            context: context,
            final_model: final_model,
            max_output_size: max_output_size,
            temperature: temperature,
            additional_properties: additional_properties,
            _field_set: _field_set,
            answer_format: answer_format
          }.compact
          req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/generate/action-items"
        end
        AssemblyAI::Lemur::LemurActionItemsResponse.from_json(json_object: response.body)
      end
    end

    # Retrieve a LeMUR response that was previously generated.
    #
    # @param request_id [String] The ID of the LeMUR request you previously made.
    #  This would be found in the response of the original request.
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::LemurStringResponse, AssemblyAI::Lemur::LemurQuestionAnswerResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.get_response(request_id: "request_id")
    def get_response(request_id:, request_options: nil)
      Async do
        response = @request_client.conn.get do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = {
        **(req.headers || {}),
        **@request_client.get_headers,
        **(request_options&.additional_headers || {})
          }.compact
          unless request_options.nil? || request_options&.additional_query_parameters.nil?
            req.params = { **(request_options&.additional_query_parameters || {}) }.compact
          end
          unless request_options.nil? || request_options&.additional_body_parameters.nil?
            req.body = { **(request_options&.additional_body_parameters || {}) }.compact
          end
          req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/#{request_id}"
        end
        AssemblyAI::Lemur::LemurResponse.from_json(json_object: response.body)
      end
    end

    # Delete the data for a previously submitted LeMUR request.
    #  The LLM response data, as well as any context provided in the original request
    #  will be removed.
    #
    # @param request_id [String] The ID of the LeMUR request whose data you want to delete. This would be found
    #  in the response of the original request.
    # @param request_options [AssemblyAI::RequestOptions]
    # @return [AssemblyAI::Lemur::PurgeLemurRequestDataResponse]
    # @example
    #  api = AssemblyAI::Client.new(
    #    base_url: "https://api.example.com",
    #    environment: AssemblyAI::Environment::DEFAULT,
    #    api_key: "YOUR_API_KEY"
    #  )
    #  api.lemur.purge_request_data(request_id: "request_id")
    def purge_request_data(request_id:, request_options: nil)
      Async do
        response = @request_client.conn.delete do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = {
        **(req.headers || {}),
        **@request_client.get_headers,
        **(request_options&.additional_headers || {})
          }.compact
          unless request_options.nil? || request_options&.additional_query_parameters.nil?
            req.params = { **(request_options&.additional_query_parameters || {}) }.compact
          end
          unless request_options.nil? || request_options&.additional_body_parameters.nil?
            req.body = { **(request_options&.additional_body_parameters || {}) }.compact
          end
          req.url "#{@request_client.get_url(request_options: request_options)}/lemur/v3/#{request_id}"
        end
        AssemblyAI::Lemur::PurgeLemurRequestDataResponse.from_json(json_object: response.body)
      end
    end
  end
end
