# frozen_string_literal: true

require 'date'

module Fugle
  module Intraday
    # The Intraday Chart
    #
    # @since 0.1.0
    # @api private
    class Chart
      include HTTP::API
      include Enumerable

      path 'intraday/chart'
      params :symbol, require: true, alias: 'symbolId'
      params :odd_lot, alias: 'oddLot'

      # @since 0.1.0
      # @api private
      def initialize(data)
        keys = data.keys
        @items = data.values.transpose.map do |row|
          Item.new(keys.zip(row).to_h)
        end
      end

      # @since 0.1.0
      # @api private
      def each(&block)
        @items.each(&block)
      end

      # Convert to JSON
      #
      # @return [String] the json string
      #
      # @since 0.1.0
      # @api private
      def to_json(*args)
        to_a.to_json(*args)
      end

      # @since 0.1.0
      # @api private
      class Item
        # @since 0.1.0
        # @api private
        attr_reader :open, :high, :low, :close, :volume, :time

        # @since 0.1.0
        # @api private
        def initialize(row)
          @time = Time.at(row['t'].to_f / 1000).to_datetime
          @open = row['o']
          @high = row['h']
          @low = row['l']
          @close = row['c']
          @volume = row['v']
        end

        # Convert to Hash
        #
        # @return [Hash] the response as hash
        #
        # @since 0.1.0
        # @api private
        def to_h
          {
            open: @open,
            high: @high,
            low: @low,
            close: @close,
            volume: @volume,
            time: @time
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
