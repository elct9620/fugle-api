# frozen_string_literal: true

require 'net/http'
require 'json'

module Fugle
  module HTTP
    # The Fugle HTTP Client
    #
    # @since 0.1.0
    # @api private
    class Client
      # @since 0.1.0
      # @api private
      def initialize
        @api = Fugle
      end

      # @since 0.1.0
      # @api private
      def respond_to_missing?(_name)
        super
      end

      # @since 0.1.0
      # @api private
      def method_missing(name, *args, &block)
        @api = find(name)
        return super if @api.nil?
        return self unless @api.is_a?(Class)

        uri = @api.uri(*args)
        res = Response.new(@api, JSON.parse(Net::HTTP.get(uri)))
        yield res.body if block_given?
        res
      end

      private

      # @since 0.1.0
      # @api private
      def find(name)
        @api.const_get(name.capitalize)
      rescue NameError
        nil
      end
    end
  end
end
