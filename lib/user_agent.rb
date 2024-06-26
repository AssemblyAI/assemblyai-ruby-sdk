# frozen_string_literal: true

require "singleton"

module AssemblyAI
  class UserAgentItem
    attr_reader :name, :value, :version

    def initialize(name:, version:)
      @name = name
      @version = version
    end
  end

  class UserAgent
    attr_reader :user_agent_items

    def initialize
      @user_agent_items = {}
    end

    # @param key [String]
    # @param user_agent_item [AssemblyAI::UserAgentItem]
    def add_item(key, user_agent_item)
      if user_agent_item.nil?
        @user_agent_items.delete(key)
      else
        @user_agent_items[key] = user_agent_item
      end
    end

    # @param user_agent1 [AssemblyAI::UserAgent]
    # @param user_agent2 [AssemblyAI::UserAgent]
    # @return [AssemblyAI::UserAgent]
    def self.merge(user_agent1, user_agent2)
      merged_user_agent = UserAgent.new

      user_agent1&.user_agent_items&.each do |key, item|
        merged_user_agent.add_item(key, item)
      end

      user_agent2&.user_agent_items&.each do |key, item|
        merged_user_agent.add_item(key, item)
      end

      merged_user_agent
    end

    # @return [String]
    def serialize
      serialized_items = @user_agent_items.map do |key, item|
        "#{key}=#{item.name}/#{item.version}"
      end.join(" ")

      "AssemblyAI/1.0 (#{serialized_items})"
    end
  end

  class DefaultUserAgent
    include Singleton

    attr_reader :user_agent

    def initialize
      @user_agent = UserAgent.new
      @user_agent.add_item("sdk", UserAgentItem.new(name: "Ruby", version: AssemblyAI::Gemconfig::VERSION))
    end
  end
end
