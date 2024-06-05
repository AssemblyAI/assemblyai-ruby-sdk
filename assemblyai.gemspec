# frozen_string_literal: true

require_relative "lib/gemconfig"

Gem::Specification.new do |spec|
  spec.name = "assemblyai"
  spec.version = "1.0.0-beta.10"
  spec.authors = AssemblyAI::Gemconfig::AUTHORS
  spec.email = AssemblyAI::Gemconfig::EMAIL
  spec.summary = AssemblyAI::Gemconfig::SUMMARY
  spec.description = AssemblyAI::Gemconfig::DESCRIPTION
  spec.homepage = AssemblyAI::Gemconfig::HOMEPAGE
  spec.required_ruby_version = ">= 2.7.0"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = AssemblyAI::Gemconfig::SOURCE_CODE_URI
  spec.metadata["changelog_uri"] = AssemblyAI::Gemconfig::CHANGELOG_URI
  spec.files = Dir.glob("lib/**/*")
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "async-http-faraday", ">= 0.0", "< 1.0"
  spec.add_dependency "faraday", ">= 1.10", "< 3.0"
  spec.add_dependency "faraday-net_http", ">= 1.0", "< 4.0"
  spec.add_dependency "faraday-retry", ">= 1.0", "< 3.0"
end
