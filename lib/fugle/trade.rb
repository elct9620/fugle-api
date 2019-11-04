# frozen_string_literal: true

module Fugle
  # The trade information
  #
  # @since 0.1.0
  # @api private
  class Trade
    # @since 0.1.0
    # @api private
    attr_reader :price, :unit, :order, :volume, :serial

    # @since 0.1.0
    # @api private
    def initialize(item)
      @price = item['price']
      @unit = item['unit']
      @order = item['order']
      @volume = item['volume']
      @serial = item['serial']
      @at = DateTime.parse(item['at']) if item['at']
    end
  end
end
