# frozen_string_literal: true

require 'fugle/trade'

module Fugle
  module Intraday
    # The Intraday Trades
    #
    # @since 0.1.0
    # @api private
    class Trades
      include HTTP::API
      include Enumerable

      path 'intraday/trades'

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
