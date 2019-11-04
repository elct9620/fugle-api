# frozen_string_literal: true

module Fugle
  module Intraday
    # The Intraday Quote
    #
    # @since 0.1.0
    # @api private
    class Quote
      class << self
        # @param symbolID [String] the symbol to query
        #
        # @since 0.1.0
        # @api private
        def call(symbol_id)
          build_uri(
            'intraday/quote',
            'symbolId' => symbol_id
          )
        end
      end

      using Utils
      include HTTP::API

      STATES = %w[Curbing Trial OpenDelayed Halting Closed].freeze

      # @since 0.1.0
      # @api private
      def initialize(data)
        STATES.each do |state|
          instance_variable_set("@#{state.underscore}", data["is#{state}"])
        end
      end

      STATES.map(&:underscore).each do |state|
        define_method "#{state}?" do
          instance_variable_get("@#{state}") == true
        end
      end
    end
  end
end
