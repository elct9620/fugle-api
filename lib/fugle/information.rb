# frozen_string_literal: true

module Fugle
  # The Information
  #
  # @since 0.1.0
  # @api private
  class Information
    # @since 0.1.0
    # @api private
    attr_reader :symbol, :mode, :timezone, :country_code

    # @since 0.1.0
    # @api private
    def initialize(attributes = {})
      @symbol = attributes.fetch('symbolId')
      @mode = attributes.fetch('mode')
      @timezone = attributes.fetch('timeZone')
      @country_code = attributes.fetch('countryCode')

      # TODO: Process lastUpdateAt, date
    end
  end
end
