# frozen_string_literal: true

module Fugle
  # @since 0.1.0
  # @api private
  class Config
    attr_writer :api_token

    # Create new config instance
    #
    # @param attributes [Hash] the default config
    # @param block [Proc] the config block
    #
    # @since 0.1.0
    # @api private
    def initialize(attributes = {}, &block)
      attributes.each do |name, value|
        send("#{name}=", value)
      end

      instance_eval(&block) if block_given?
    end

    # The API Token
    #
    # @return [String] the api token
    #
    # @since 0.1.0
    def api_token
      @api_token || ENV['FUGLE_API_TOKEN']
    end
  end
end
