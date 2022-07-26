require_relative 'lib/kitman/athleteservice/version'

Gem::Specification.new do |spec|
  spec.name          = "athleteservice"
  spec.version       = Kitman::AthleteService::VERSION
  spec.authors       = ["stef-cruz"]
  spec.email         = ["scruz@kitmanlabs.com"]

  spec.summary       = %q{Gem created to connect to Athlete Service API.}
  spec.homepage      = "https://github.com/stef-cruz/athleteservice"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/stef-cruz/athleteservice"
  spec.metadata["changelog_uri"] = "https://github.com/stef-cruz/athleteservice/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency('faraday', '~> 1.7')
  # faraday_middleware converts json into ruby hash automatically. No need to write json.parse
  spec.add_development_dependency('faraday_middleware', '~> 1.1')
  spec.add_development_dependency('byebug')
  spec.add_development_dependency('webmock', '~> 3.0')
  spec.add_development_dependency('simplecov', '~> 0.15')
  spec.add_development_dependency('rubocop', '~> 1.31.2')
end
