# frozen_string_literal: true

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
      VERSION = 'v0'

      # @since 0.1.0
      # @api private
      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
      end

      # @since 0.1.0
      # @api private
      module ClassMethods
        # @since 0.1.0
        # @api private

        def build_uri(path, parameters = {})
          uri = URI("#{ENDPOINT}/#{VERSION}/#{path}")
          uri.query = URI.encode_www_form(
            parameters.merge('apiToken' => Fugle.config.api_token)
          )
          uri
        end
      end
    end
  end
end
