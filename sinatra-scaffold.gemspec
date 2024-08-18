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
  spec.description = "Ruby gem to make more easy the getting start of web app development with Sinatra gem"
  spec.homepage = "https://github.com/joaoGabriel55/sinatra-scaffold"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["*.md", "bin/*", "lib/**/*.rb"]
  spec.executables = ["sinatra-scaffold"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency "standard", "~> 1.3"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "thor", "~> 1.3"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
