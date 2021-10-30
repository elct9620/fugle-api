# frozen_string_literal: true

require 'date'
require 'fugle/trade'

module Fugle
  module Intraday
    # The Intraday Quote
    #
    # @since 0.1.0
    # @api private
    class Quote
      using Utils
      include HTTP::API
      include Utils

      path 'intraday/quote'
      params :symbol, require: true, alias: 'symbolId'

      # TODO: Add more quote attribute support
      # @since 0.1.0
      # @api private
      attr_reader :total, :trial, :trade, :price, :orders

      # @since 0.1.0
      # @api private
      STATES = %w[Curbing CurbingFall CurbingRise
                  Trial OpenDelayed Halting Closed].freeze

      # @since 0.1.0
      # @api private
      def initialize(data)
        load_boolean STATES, data, prefix: 'is'

        # TODO: Refactor to total object
        @total = Trade.new(data['total'])
        @trial = Trade.new(data['trial'])
        @trade = Trade.new(data['trade'])
        @price = Price.new(data)
        @order = Order.new(data['order'])
      end

      # @since 0.1.0
      # @api private
      STATES.map(&:underscore).each do |state|
        define_method "#{state}?" do
          instance_variable_get("@#{state}") == true
        end
      end

      # Convert to Hash
      #
      # @return [Hash] the response as hash
      #
      # @since 0.1.0
      # @api private
      def to_h
        {
          total: @total,
          trial: @trial,
          trade: @trade,
          price: @price,
          order: @order
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

      # @since 0.1.0
      # @api private
      class Price
        # @since 0.1.0
        # @api private
        attr_reader :high, :low, :open, :average

        # @since 0.1.0
        # @api private
        def initialize(data)
          # TODO: Refactor to Price object
          @high = Trade.new(data['priceHigh'])
          @low = Trade.new(data['priceLow'])
          @open = Trade.new(data['priceOpen'])
          @average = Trade.new(data['priceAvg'])
        end

        # Convert to Hash
        #
        # @return [Hash] the response as hash
        #
        # @since 0.1.0
        # @api private
        def to_h
          {
            high: @high,
            low: @low,
            open: @open
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

      # @since 0.1.0
      # @api private
      class Order
        # @since 0.1.0
        # @api private
        attr_reader :update_at, :bids, :asks

        # @since 0.1.0
        # @api private
        def initialize(data)
          @updated_at = DateTime.parse(data['at'])
          # TODO: Refactor to Bid/Ask object
          @bids = data['bids'].map { |item| Trade.new(item) }
          @asks = data['asks'].map { |item| Trade.new(item) }
        end

        # Convert to Hash
        #
        # @return [Hash] the response as hash
        #
        # @since 0.1.0
        # @api private
        def to_h
          {
            updated_at: @updated_at,
            bids: @bids,
            asks: @asks
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
  end
end
