# frozen_string_literal: true

require 'forwardable'

module Fugle
  module HTTP
    # @since 0.1.0
    # @api private
    class Error
      extend Forwardable

      delegate %i[code message] => :body

      # @since 0.1.0
      # @api private
      attr_reader :info, :body

      # @since 0.1.0
      # @api private
      def initialize(api, body)
        @api = api
        @version = body['apiVersion']
        @body = Body.new(body['error'])
      end

      # Convert to Hash
      #
      # @return [Hash] the response as hash
      #
      # @since 0.1.0
      # @api private
      def to_h
        {
          version: @version,
          body: @body
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

      # @since 0.1.0
      # @api private
      class Body
        # @since 0.1.0
        # @api private
        attr_reader :code, :message

        # @since 0.1.0
        # @api private
        def initialize(error)
          @code = error['code']
          @message = error['message']
        end

        # Convert to Hash
        #
        # @return [Hash] the response as hash
        #
        # @since 0.1.0
        # @api private
        def to_h
          {
            code: @code,
            message: @message
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
