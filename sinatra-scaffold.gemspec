# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Load the version directly from the source tree.
require "sinatra_scaffold/version"

Gem::Specification.new do |spec|
  spec.name = "sinatra-scaffold"
  spec.version = SinatraScaffold::VERSION
  spec.authors = ["joaoGabriel55"]
  spec.email = ["joaoGabriel55"]

  spec.summary = "Scaffold for Sinatra applications"
  spec.description = "Scaffold for Sinatra applications"
  spec.homepage = "https://github.com/joaoGabriel55/sinatra-scaffold"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/joaoGabriel55/sinatra-scaffold"
  spec.metadata["changelog_uri"] = "https://github.com/joaoGabriel55/sinatra-scaffold/blob/main/CHANGELOG.md"

  spec.files = Dir["*.md", "bin/*", "lib/**/*.rb"]
  spec.executables = ["sinatra-scaffold"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_runtime_dependency 'thor', '~> 1.3'
  # spec.add_development_dependency 'rake', '~> 13.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
