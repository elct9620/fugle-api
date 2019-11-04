# frozen_string_literal: true

module Fugle
  module Intraday
    # The Intraday Meta
    #
    # @since 0.1.0
    # @api private
    class Meta
      class << self
        # @param symbolID [String] the symbol to query
        #
        # @since 0.1.0
        # @api private
        def call(symbol_id)
          build_uri(
            'intraday/meta',
            'symbolId' => symbol_id
          )
        end
      end

      using Utils
      include HTTP::API

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

      private

      # @since 0.1.0
      # @api private
      def load_boolean(attributes, data, prefix: 'is')
        attributes.each do |attr|
          instance_variable_set(
            "@#{attr.underscore}",
            data["#{prefix}#{attr}"]
          )
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
