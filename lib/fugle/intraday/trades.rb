# frozen_string_literal: true

module Fugle
  module Intraday
    # The Intraday Trades
    #
    # @since 0.1.0
    # @api private
    class Trades
      class << self
        # @param symbolID [String] the symbol to query
        #
        # @since 0.1.0
        # @api private
        def call(symbol_id)
          build_uri(
            'intraday/trades',
            'symbolId' => symbol_id
          )
        end
      end

      include HTTP::API
      include Enumerable

      # @since 0.1.0
      # @api private
      def initialize(items)
        @items = items.map { |item| Item.new(item) }
      end

      # @since 0.1.0
      # @api private
      def each(&block)
        @items.each(&block)
      end

      # @since 0.1.0
      # @api private
      class Item
        # @since 0.1.0
        # @api private
        attr_reader :price, :unit, :volume, :serial

        # @since 0.1.0
        # @api private
        def initialize(item)
          @price = item['price']
          @unit = item['unit']
          @volume = item['volume']
          @serial = item['serial']
          @at = DateTime.parse(item['at'])
        end
      end
    end
  end
end
