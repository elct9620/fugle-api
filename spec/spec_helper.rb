# frozen_string_literal: true

require 'simplecov'
require 'dotenv'

Dotenv.load unless ENV['CI']

SimpleCov.start do
  load_profile 'test_frameworks'
end

require 'fugle'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
