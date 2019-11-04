# frozen_string_literal: true

module Fugle
  module Intraday
    # The Intraday Meta
    #
    # @since 0.1.0
    # @api private
    class Meta
      using Utils
      include HTTP::API
      include Utils

      path 'intraday/meta'
      params :symbol, require: true, alias: 'symbolId'

      # @since 0.1.0
      # @api private
      attr_reader :name, :industry, :type, :price

      # @since 0.1.0
      # @api private
      STATES = %w[Index Terminated Suspended Warrant].freeze
      PERMITS = %w[DayBuySell DaySellBuy ShortMargin ShortLend].freeze

      # @since 0.1.0
      # @api private
      def initialize(data)
        load_boolean STATES, data, prefix: 'is'
        load_boolean PERMITS, data, prefix: 'can'

        @name = data['nameZhTw']
        @industry = data['industryZhTw']
        @type = data['typeZhTw']
        @price = Price.new(data)
      end

      # @since 0.1.0
      # @api private
      STATES.map(&:underscore).each do |state|
        define_method("#{state}?") do
          instance_variable_get("@#{state}") == true
        end
      end

      # @since 0.1.0
      # @api private
      PERMITS.map(&:underscore).each do |permit|
        define_method("#{permit}?") do
          instance_variable_get("@#{permit}") == true
        end
      end

      # @since 0.1.0
      # @api private
      class Price
        # @since 0.1.0
        # @api private
        attr_reader :reference, :high_limit, :low_limit, :currency

        # @since 0.1.0
        # @api private
        def initialize(data)
          @reference = data['priceReference']
          @high_limit = data['priceHighLimit']
          @low_limit = data['priceLowLimit']
          @currency = data['currency']
        end
      end
    end
  end
end
