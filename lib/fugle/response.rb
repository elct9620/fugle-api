# frozen_string_literal: true

module Fugle
  # API Response
  #
  # @since 0.1.0
  # @api private
  class Response
    # @since 0.1.0
    # @api private
    attr_reader :version, :info, :body

    # Create a new response
    #
    # @param attributes [Hash] response Hash from API
    #
    # @since 0.1.0
    # @api private
    def initialize(body, attributes)
      @version = attributes.fetch('apiVersion', nil)
      @info = Information.new(attributes.dig('data', 'info'))
      @body = body.new(attributes.dig('data', body.data_name))
    end
  end
end
