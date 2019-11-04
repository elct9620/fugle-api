# frozen_string_literal: true

require 'date'

module Fugle
  # The Information
  #
  # @since 0.1.0
  # @api private
  class Information
    # @since 0.1.0
    # @api private
    attr_reader :symbol, :mode, :timezone, :country_code, :update_at

    # @since 0.1.0
    # @api private
    def initialize(attributes = {})
      @symbol = attributes['symbolId']
      @mode = attributes['mode']
      @timezone = attributes['timeZone']
      @country_code = attributes['countryCode']
      @update_at = DateTime.parse(attributes['lastUpdatedAt'])
      @date = Date.parse(attributes['date'])
    end
  end
end
