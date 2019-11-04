# frozen_string_literal: true

require 'fugle/version'
require 'fugle/config'
require 'fugle/http'
require 'fugle/intraday'
require 'fugle/response'
require 'fugle/information'

# The Fugle.tw API Client
#
# @api private
module Fugle
  class Error < StandardError; end

  # The Fugle Config
  #
  # @param block [Proc] the configure block
  #
  # @return [Fugle::Config] the config
  #
  # @since 0.1.0
  # @api private
  def self.config(&block)
    @config ||= Config.new
    @config.instance_eval(&block) if block_given?
    @config
  end

  # @since 0.1.0
  # @api private
  def self.http
    HTTP::Client.new
  end
end
