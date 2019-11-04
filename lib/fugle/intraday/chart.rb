# frozen_string_literal: true

require 'date'

module Fugle
  module Intraday
    # The Intraday Chart
    #
    # @since 0.1.0
    # @api private
    class Chart
      class << self
        # @param symbolID [String] the symbol to query
        #
        # @since 0.1.0
        # @api private
        def call(symbol_id)
          build_uri(
            'intraday/chart',
            'symbolId' => symbol_id
          )
        end
      end

      include HTTP::API
      include Enumerable

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
      end
    end
  end
end
