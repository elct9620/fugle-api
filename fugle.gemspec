# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fugle/version'

Gem::Specification.new do |spec|
  spec.name          = 'fugle'
  spec.version       = Fugle::VERSION
  spec.authors       = ['蒼時弦也']
  spec.email         = ['contact@frost.tw']

  spec.summary       = 'The Fugle.tw API Client'
  spec.description   = 'The Fugle.tw API Client'
  spec.homepage      = 'https://github.com/elct9620/fugle-api'

  spec.required_ruby_version = '>= 2.6'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files
  # in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
end
