# frozen_string_literal: true

module Fugle
  # Utils
  #
  # @since 0.1.0
  # @api private
  module Utils
    refine String do
      # Convert camel to underscore
      #
      # @since 0.1.0
      # @api private
      def underscore
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .downcase
      end
    end

    using self

    private

    # @since 0.1.0
    # @api private
    def load_boolean(attributes, data, prefix: 'is')
      attributes.each do |name|
        instance_variable_set(
          "@#{name.underscore}",
          data["#{prefix}#{name}"]
        )
      end
    end
  end
end
