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
    attr_reader :symbol, :type, :exchange, :market,
                :timezone, :country_code, :updated_at, :date

    # @since 0.1.0
    # @api private
    def initialize(attributes = {})
      @symbol = attributes['symbolId']
      @type = attributes['type']
      @exchange = attributes['exchange']
      @market = attributes['market']
      @timezone = attributes['timeZone']
      @country_code = attributes['countryCode']
      @updated_at = DateTime.parse(attributes['lastUpdatedAt'])
      @date = Date.parse(attributes['date'])
    end

    # Convert to Hash
    #
    # @return [Hash] the response as hash
    #
    # @since 0.1.0
    # @api private
    def to_h
      {
        symbol: @symbol,
        type: @type,
        exchange: @exchange,
        market: @market,
        timezone: @timezone,
        country_code: @country_code,
        date: @date,
        updated_at: @updated_at
      }
    end

    # Convert to JSON
    #
    # @return [String] the json string
    #
    # @since 0.1.0
    # @api private
    def to_json(*args)
      to_h.to_json(*args)
    end
  end
end
