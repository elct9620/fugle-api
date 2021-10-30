# frozen_string_literal: true

require 'fugle/http/parameters'
require 'fugle/http/query'

module Fugle
  module HTTP
    # @since 0.1.0
    # @api private
    module API
      # @since 0.1.0
      # @api private
      ENDPOINT = 'https://api.fugle.tw/realtime'

      # @since 0.1.0
      # @api private
      VERSION = 'v0.3'

      # @since 0.1.0
      # @api private
      def self.included(base)
        base.class_eval do
          @_path = nil
          @_parameters = Parameters.new

          extend ClassMethods
        end
      end

      # @since 0.1.0
      # @api private
      module ClassMethods
        # @since 0.1.0
        # @api private
        def path(value = nil)
          return @_path if value.nil?

          @_path = value
        end

        # @since 0.1.0
        # @api private
        def params(name, options = {})
          @_parameters.add(name, options)
        end

        # @since 0.1.0
        # @api private
        def parameters
          @_parameters
        end

        # @since 0.1.0
        # @api private
        def uri(query = {})
          uri = URI("#{ENDPOINT}/#{VERSION}/#{path}")
          uri.query = Query.new(
            query.merge(apiToken: Fugle.config.api_token),
            parameters
          ).to_s
          uri
        end

        # @since 0.1.0
        # @api private
        def data_name
          @data_name ||= name.split('::').last.downcase
        end
      end
    end
  end
end
