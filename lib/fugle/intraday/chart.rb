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

      # @since 0.1.0
      # @api private
      def initialize(data)
        @items = data.map do |time, row|
          Item.new(row, time)
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
        attr_reader :open, :high, :low, :close, :unit, :volume, :time

        # @since 0.1.0
        # @api private
        def initialize(attributes, time)
          @time = DateTime.parse(time)
          attributes.each do |name, value|
            instance_variable_set("@#{name}", value)
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
            open: @open,
            high: @high,
            low: @low,
            close: @close,
            unit: @unit,
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
