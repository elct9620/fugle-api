# frozen_string_literal: true

module Fugle
  # Utils
  #
  # @since 0.1.0
  # @api private
  module Utils
    refine String do
      def underscore
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .downcase
      end
    end
  end
end
