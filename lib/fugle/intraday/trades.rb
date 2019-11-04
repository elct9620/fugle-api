# frozen_string_literal: true

require 'fugle/trade'

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
        @items = items.map { |item| Trade.new(item) }
      end

      # @since 0.1.0
      # @api private
      def each(&block)
        @items.each(&block)
      end
    end
  end
end
