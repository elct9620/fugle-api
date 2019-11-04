# frozen_string_literal: true

module Fugle
  module HTTP
    # @since 0.1.0
    # @api private
    class Parameters
      # @since 0.1.0
      # @api private
      def initialize
        @items = []
      end

      # @since 0.1.0
      # @api private
      def add(name, options = {})
        @items.push(
          name: name.to_sym,
          required: options[:required] == true,
          alias: options[:alias]
        )
      end

      # @since 0.1.0
      # @api private
      def requires
        @requires ||=
          @items.select { |item| item[:required] }
      end

      # @since 0.1.0
      # @api private
      def [](name)
        @items.find { |item| item[:name] == name }
      end
    end
  end
end
