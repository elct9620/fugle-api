# frozen_string_literal: true

module Fugle
  module HTTP
    # HTTP Query String
    #
    # @since 0.1.0
    # @api private
    class Query
      # @since 0.1.0
      # @api private
      class MissingParameterError < RuntimeError; end

      # Create new query
      #
      # @param query [Hash] the user inputs query
      # @param parameters [Array<Hash>] the api parameter requirements
      #
      # @since 0.1.0
      # @api private
      def initialize(query, parameters)
        @query = query
        @parameters = parameters

        verify!
      end

      # Verify parameters
      #
      # @since 0.1.0
      # @api private
      def verify!
        raise MissingParameterError unless all_required?

        true
      end

      # @since 0.1.0
      # @api private
      def all_required?
        @parameters
          .requires
          .reduce(true) do |prev, curr|
            @query[curr[:name]] && prev
          end
      end

      # @since 0.1.0
      # @api private
      def to_h
        @query
          .to_h do |name, value|
            as = @parameters[name]&.fetch(:alias, nil)
            [as || name, value]
          end
      end

      # @since 0.1.0
      # @api private
      def to_s
        URI.encode_www_form(to_h)
      end
    end
  end
end
