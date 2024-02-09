# frozen_string_literal: true

require_relative "../../requests"
require_relative "types/lemur_base_params_context"
require_relative "types/lemur_model"
require_relative "types/lemur_task_response"
require_relative "types/lemur_summary_response"
require_relative "types/lemur_question"
require_relative "types/lemur_question_answer_response"
require_relative "types/lemur_action_items_response"
require_relative "types/purge_lemur_request_data_response"
require "async"

module AssemblyAI
  class LemurClient
    attr_reader :request_client

    # @param request_client [RequestClient]
    # @return [LemurClient]
    def initialize(request_client:)
      # @type [RequestClient]
      @request_client = request_client
    end

    # Use the LeMUR task endpoint to input your own LLM prompt.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100 hours, whichever is lower.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the selected model, which defaults to 100000.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param context [Hash] Context to provide the model. This can be a string or a free-form JSON value.Request of type Lemur::LemurBaseParamsContext, as a Hash
    # @param final_model [LEMUR_MODEL] The model that is used for the final prompt after compression is performed.
    #   Defaults to "default".
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #   Higher values result in answers that are more creative, lower values are more conservative.
    #   Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param prompt [String] Your text to prompt the model to produce a desired output, including any context you want to pass into the model.
    # @param request_options [RequestOptions]
    # @return [Lemur::LemurTaskResponse]
    def task(prompt:, transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
             temperature: nil, additional_properties: nil, request_options: nil)
      response = @request_client.conn.post("/lemur/v3/generate/task") do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
        req.body = {
          **(request_options&.additional_body_parameters || {}),
          transcript_ids: transcript_ids,
          input_text: input_text,
          context: context,
          final_model: final_model,
          max_output_size: max_output_size,
          temperature: temperature,
          additional_properties: additional_properties,
          prompt: prompt
        }.compact
      end
      Lemur::LemurTaskResponse.from_json(json_object: response.body)
    end

    # Custom Summary allows you to distill a piece of audio into a few impactful sentences. You can give the model context to obtain more targeted results while outputting the results in a variety of formats described in human language.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100 hours, whichever is lower.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the selected model, which defaults to 100000.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param context [Hash] Context to provide the model. This can be a string or a free-form JSON value.Request of type Lemur::LemurBaseParamsContext, as a Hash
    # @param final_model [LEMUR_MODEL] The model that is used for the final prompt after compression is performed.
    #   Defaults to "default".
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #   Higher values result in answers that are more creative, lower values are more conservative.
    #   Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param answer_format [String] How you want the summary to be returned. This can be any text. Examples: "TLDR", "bullet points"
    # @param request_options [RequestOptions]
    # @return [Lemur::LemurSummaryResponse]
    def summary(transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                temperature: nil, additional_properties: nil, answer_format: nil, request_options: nil)
      response = @request_client.conn.post("/lemur/v3/generate/summary") do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
        req.body = {
          **(request_options&.additional_body_parameters || {}),
          transcript_ids: transcript_ids,
          input_text: input_text,
          context: context,
          final_model: final_model,
          max_output_size: max_output_size,
          temperature: temperature,
          additional_properties: additional_properties,
          answer_format: answer_format
        }.compact
      end
      Lemur::LemurSummaryResponse.from_json(json_object: response.body)
    end

    # Question & Answer allows you to ask free-form questions about a single transcript or a group of transcripts. The questions can be any whose answers you find useful, such as judging whether a caller is likely to become a customer or whether all items on a meeting's agenda were covered.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100 hours, whichever is lower.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the selected model, which defaults to 100000.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param context [Hash] Context to provide the model. This can be a string or a free-form JSON value.Request of type Lemur::LemurBaseParamsContext, as a Hash
    # @param final_model [LEMUR_MODEL] The model that is used for the final prompt after compression is performed.
    #   Defaults to "default".
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #   Higher values result in answers that are more creative, lower values are more conservative.
    #   Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param questions [Array<Hash>] A list of questions to askRequest of type Array<Lemur::LemurQuestion>, as a Hash
    #   * :question (String)
    #   * :context (Hash)
    #   * :answer_format (String)
    #   * :answer_options (Array<String>)
    # @param request_options [RequestOptions]
    # @return [Lemur::LemurQuestionAnswerResponse]
    def question_answer(questions:, transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                        temperature: nil, additional_properties: nil, request_options: nil)
      response = @request_client.conn.post("/lemur/v3/generate/question-answer") do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
        req.body = {
          **(request_options&.additional_body_parameters || {}),
          transcript_ids: transcript_ids,
          input_text: input_text,
          context: context,
          final_model: final_model,
          max_output_size: max_output_size,
          temperature: temperature,
          additional_properties: additional_properties,
          questions: questions
        }.compact
      end
      Lemur::LemurQuestionAnswerResponse.from_json(json_object: response.body)
    end

    # Use LeMUR to generate a list of action items from a transcript
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100 hours, whichever is lower.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the selected model, which defaults to 100000.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param context [Hash] Context to provide the model. This can be a string or a free-form JSON value.Request of type Lemur::LemurBaseParamsContext, as a Hash
    # @param final_model [LEMUR_MODEL] The model that is used for the final prompt after compression is performed.
    #   Defaults to "default".
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #   Higher values result in answers that are more creative, lower values are more conservative.
    #   Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param answer_format [String] How you want the action items to be returned. This can be any text.
    #   Defaults to "Bullet Points".
    # @param request_options [RequestOptions]
    # @return [Lemur::LemurActionItemsResponse]
    def action_items(transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                     temperature: nil, additional_properties: nil, answer_format: nil, request_options: nil)
      response = @request_client.conn.post("/lemur/v3/generate/action-items") do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
        req.body = {
          **(request_options&.additional_body_parameters || {}),
          transcript_ids: transcript_ids,
          input_text: input_text,
          context: context,
          final_model: final_model,
          max_output_size: max_output_size,
          temperature: temperature,
          additional_properties: additional_properties,
          answer_format: answer_format
        }.compact
      end
      Lemur::LemurActionItemsResponse.from_json(json_object: response.body)
    end

    # Delete the data for a previously submitted LeMUR request.
    # The LLM response data, as well as any context provided in the original request will be removed.
    #
    # @param request_id [String] The ID of the LeMUR request whose data you want to delete. This would be found in the response of the original request.
    # @param request_options [RequestOptions]
    # @return [Lemur::PurgeLemurRequestDataResponse]
    def purge_request_data(request_id:, request_options: nil)
      response = @request_client.conn.delete("/lemur/v3/#{request_id}") do |req|
        req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
        req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
        req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
      end
      Lemur::PurgeLemurRequestDataResponse.from_json(json_object: response.body)
    end
  end

  class AsyncLemurClient
    attr_reader :request_client

    # @param request_client [AsyncRequestClient]
    # @return [AsyncLemurClient]
    def initialize(request_client:)
      # @type [AsyncRequestClient]
      @request_client = request_client
    end

    # Use the LeMUR task endpoint to input your own LLM prompt.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100 hours, whichever is lower.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the selected model, which defaults to 100000.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param context [Hash] Context to provide the model. This can be a string or a free-form JSON value.Request of type Lemur::LemurBaseParamsContext, as a Hash
    # @param final_model [LEMUR_MODEL] The model that is used for the final prompt after compression is performed.
    #   Defaults to "default".
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #   Higher values result in answers that are more creative, lower values are more conservative.
    #   Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param prompt [String] Your text to prompt the model to produce a desired output, including any context you want to pass into the model.
    # @param request_options [RequestOptions]
    # @return [Lemur::LemurTaskResponse]
    def task(prompt:, transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
             temperature: nil, additional_properties: nil, request_options: nil)
      Async do
        response = @request_client.conn.post("/lemur/v3/generate/task") do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
          req.body = {
            **(request_options&.additional_body_parameters || {}),
            transcript_ids: transcript_ids,
            input_text: input_text,
            context: context,
            final_model: final_model,
            max_output_size: max_output_size,
            temperature: temperature,
            additional_properties: additional_properties,
            prompt: prompt
          }.compact
        end
        Lemur::LemurTaskResponse.from_json(json_object: response.body)
      end
    end

    # Custom Summary allows you to distill a piece of audio into a few impactful sentences. You can give the model context to obtain more targeted results while outputting the results in a variety of formats described in human language.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100 hours, whichever is lower.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the selected model, which defaults to 100000.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param context [Hash] Context to provide the model. This can be a string or a free-form JSON value.Request of type Lemur::LemurBaseParamsContext, as a Hash
    # @param final_model [LEMUR_MODEL] The model that is used for the final prompt after compression is performed.
    #   Defaults to "default".
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #   Higher values result in answers that are more creative, lower values are more conservative.
    #   Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param answer_format [String] How you want the summary to be returned. This can be any text. Examples: "TLDR", "bullet points"
    # @param request_options [RequestOptions]
    # @return [Lemur::LemurSummaryResponse]
    def summary(transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                temperature: nil, additional_properties: nil, answer_format: nil, request_options: nil)
      Async do
        response = @request_client.conn.post("/lemur/v3/generate/summary") do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
          req.body = {
            **(request_options&.additional_body_parameters || {}),
            transcript_ids: transcript_ids,
            input_text: input_text,
            context: context,
            final_model: final_model,
            max_output_size: max_output_size,
            temperature: temperature,
            additional_properties: additional_properties,
            answer_format: answer_format
          }.compact
        end
        Lemur::LemurSummaryResponse.from_json(json_object: response.body)
      end
    end

    # Question & Answer allows you to ask free-form questions about a single transcript or a group of transcripts. The questions can be any whose answers you find useful, such as judging whether a caller is likely to become a customer or whether all items on a meeting's agenda were covered.
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100 hours, whichever is lower.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the selected model, which defaults to 100000.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param context [Hash] Context to provide the model. This can be a string or a free-form JSON value.Request of type Lemur::LemurBaseParamsContext, as a Hash
    # @param final_model [LEMUR_MODEL] The model that is used for the final prompt after compression is performed.
    #   Defaults to "default".
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #   Higher values result in answers that are more creative, lower values are more conservative.
    #   Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param questions [Array<Hash>] A list of questions to askRequest of type Array<Lemur::LemurQuestion>, as a Hash
    #   * :question (String)
    #   * :context (Hash)
    #   * :answer_format (String)
    #   * :answer_options (Array<String>)
    # @param request_options [RequestOptions]
    # @return [Lemur::LemurQuestionAnswerResponse]
    def question_answer(questions:, transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                        temperature: nil, additional_properties: nil, request_options: nil)
      Async do
        response = @request_client.conn.post("/lemur/v3/generate/question-answer") do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
          req.body = {
            **(request_options&.additional_body_parameters || {}),
            transcript_ids: transcript_ids,
            input_text: input_text,
            context: context,
            final_model: final_model,
            max_output_size: max_output_size,
            temperature: temperature,
            additional_properties: additional_properties,
            questions: questions
          }.compact
        end
        Lemur::LemurQuestionAnswerResponse.from_json(json_object: response.body)
      end
    end

    # Use LeMUR to generate a list of action items from a transcript
    #
    # @param transcript_ids [Array<String>] A list of completed transcripts with text. Up to a maximum of 100 files or 100 hours, whichever is lower.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param input_text [String] Custom formatted transcript data. Maximum size is the context limit of the selected model, which defaults to 100000.
    #   Use either transcript_ids or input_text as input into LeMUR.
    # @param context [Hash] Context to provide the model. This can be a string or a free-form JSON value.Request of type Lemur::LemurBaseParamsContext, as a Hash
    # @param final_model [LEMUR_MODEL] The model that is used for the final prompt after compression is performed.
    #   Defaults to "default".
    # @param max_output_size [Integer] Max output size in tokens, up to 4000
    # @param temperature [Float] The temperature to use for the model.
    #   Higher values result in answers that are more creative, lower values are more conservative.
    #   Can be any value between 0.0 and 1.0 inclusive.
    # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
    # @param answer_format [String] How you want the action items to be returned. This can be any text.
    #   Defaults to "Bullet Points".
    # @param request_options [RequestOptions]
    # @return [Lemur::LemurActionItemsResponse]
    def action_items(transcript_ids: nil, input_text: nil, context: nil, final_model: nil, max_output_size: nil,
                     temperature: nil, additional_properties: nil, answer_format: nil, request_options: nil)
      Async do
        response = @request_client.conn.post("/lemur/v3/generate/action-items") do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
          req.body = {
            **(request_options&.additional_body_parameters || {}),
            transcript_ids: transcript_ids,
            input_text: input_text,
            context: context,
            final_model: final_model,
            max_output_size: max_output_size,
            temperature: temperature,
            additional_properties: additional_properties,
            answer_format: answer_format
          }.compact
        end
        Lemur::LemurActionItemsResponse.from_json(json_object: response.body)
      end
    end

    # Delete the data for a previously submitted LeMUR request.
    # The LLM response data, as well as any context provided in the original request will be removed.
    #
    # @param request_id [String] The ID of the LeMUR request whose data you want to delete. This would be found in the response of the original request.
    # @param request_options [RequestOptions]
    # @return [Lemur::PurgeLemurRequestDataResponse]
    def purge_request_data(request_id:, request_options: nil)
      Async do
        response = @request_client.conn.delete("/lemur/v3/#{request_id}") do |req|
          req.options.timeout = request_options.timeout_in_seconds unless request_options&.timeout_in_seconds.nil?
          req.headers["Authorization"] = request_options.api_key unless request_options&.api_key.nil?
          req.headers = { **req.headers, **(request_options&.additional_headers || {}) }.compact
        end
        Lemur::PurgeLemurRequestDataResponse.from_json(json_object: response.body)
      end
    end
  end
end
