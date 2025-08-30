# frozen_string_literal: true

require_relative "lib/tailscale/rails/version"

Gem::Specification.new do |spec|
  spec.name = "tailscale-rails"
  spec.version = Tailscale::Rails::VERSION
  spec.authors = ["CoderMiguel"]
  spec.email = ["52347827+CoderMiguel@users.noreply.github.com"]

  spec.summary = "Interacting with Tailscale in Rails applications"
  # spec.description = "TODO: Write a longer description or delete this line."
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  #   spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rake", "~> 13.3"
  # TODO: consider Open3 stdlib instead of terrapin to limit dependencies
  # currently using because it has safeguards against malicious cli input
  # https://github.com/thoughtbot/terrapin
  spec.add_runtime_dependency "terrapin", "~> 1.1"

  # spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "pry", "~> 0.15"
end
