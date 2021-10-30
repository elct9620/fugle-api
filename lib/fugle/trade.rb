# frozen_string_literal: true

module Fugle
  # The trade information
  #
  # @since 0.1.0
  # @api private
  class Trade
    # @since 0.1.0
    # @api private
    attr_reader :price, :bid, :ask, :volume, :updated_at

    # @since 0.1.0
    # @api private
    def initialize(item)
      @price = item['price']
      @bid = item['bid']
      @ask = item['ask']
      @volume = item['volume']
      @updated_at = DateTime.parse(item['at']) if item['at']
    end

    # Convert to Hash
    #
    # @return [Hash] the response as hash
    #
    # @since 0.1.0
    # @api private
    def to_h
      {
        price: @price,
        bid: @bid,
        ask: @ask,
        volume: @volume,
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
