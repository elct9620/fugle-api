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

      # Convert to Hash
      #
      # @return [Hash] the response as hash
      #
      # @since 0.1.0
      # @api private
      # rubocop:disable Metrics/MethodLength
      def to_h
        {
          name: @name,
          industry: @industry,
          type: @type,
          price: @price,
          is_index: index?,
          is_terminated: terminated?,
          is_suspended: suspended?,
          is_warrant: warrant?,
          can_day_buy_sell: day_buy_sell?,
          can_day_sell_buy: day_sell_buy?,
          can_short_margin: short_margin?,
          can_short_lend: short_lend?
        }
      end
      # rubocop:enable Metrics/MethodLength

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
        attr_reader :reference, :high_limit, :low_limit, :currency

        # @since 0.1.0
        # @api private
        def initialize(data)
          @reference = data['priceReference']
          @high_limit = data['priceHighLimit']
          @low_limit = data['priceLowLimit']
          @currency = data['currency']
        end

        # Convert to Hash
        #
        # @return [Hash] the response as hash
        #
        # @since 0.1.0
        # @api private
        def to_h
          {
            reference: @reference,
            high_limit: @high_limit,
            low_limit: @low_limit,
            currency: @currency
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
