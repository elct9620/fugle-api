# frozen_string_literal: true

require 'fugle/version'
require 'fugle/utils'
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

  # @since 0.1.0
  # @api private
  LOCK = Mutex.new

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

  # Temporary change config
  #
  # @param config [Fugle::Config] the config object
  # @param block [Proc] the temporary working block
  #
  # @since 0.1.0
  # @api private
  def self.use(config, &_block)
    LOCK.synchronize do
      temp = Fugle.config
      @config = config
      res = yield
      @config = temp
      res
    end
  end

  # @since 0.1.0
  # @api private
  def self.http
    HTTP::Client.new
  end

  # @since 0.1.0
  # @api private
  def self.intraday
    http.intraday
  end
end
