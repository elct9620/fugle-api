# frozen_string_literal: true

require 'net/http'
require 'json'
require 'fugle/http/error'

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

        res = fetch(@api.uri(*args))
        yield res.body if block_given?
        res
      end

      private

      # @since 0.1.0
      # @api private
      def fetch(uri)
        use_ssl = uri.scheme == 'https'
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: use_ssl) do |http|
          http.request Net::HTTP::Get.new(uri)
        end
        body = JSON.parse(res.body)
        return Response.new(@api, body) if res.is_a?(Net::HTTPSuccess)

        Error.new(@api, body)
      end

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
