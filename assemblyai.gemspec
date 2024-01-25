# frozen_string_literal: true

require_relative "lib/gemconfig"

Gem::Specification.new do |spec|
  spec.name = "assemblyai"
  spec.version = AssemblyAI::Gemconfig::VERSION
  spec.authors = AssemblyAI::Gemconfig::AUTHORS
  spec.email = AssemblyAI::Gemconfig::EMAIL
  spec.summary = AssemblyAI::Gemconfig::SUMMARY
  spec.description = AssemblyAI::Gemconfig::DESCRIPTION
  spec.homepage = AssemblyAI::Gemconfig::HOMEPAGE
  spec.required_ruby_version = ">= 2.6.0"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = AssemblyAI::Gemconfig::SOURCE_CODE_URI
  spec.metadata["changelog_uri"] = AssemblyAI::Gemconfig::CHANGELOG_URI
  spec.files = Dir.glob("lib/**/*")
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
