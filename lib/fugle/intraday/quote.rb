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

      include HTTP::API
    end
  end
end
