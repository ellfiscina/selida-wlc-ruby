require 'time'
require 'json'
require 'faraday'
require 'awrence'
require 'plissken'
require 'forwardable'
require 'wlc/api'
require 'wlc/auth'
require 'wlc/error'
require 'wlc/token'
require 'wlc/client'
require 'wlc/awrence'
require 'wlc/request'
require 'wlc/version'
require 'wlc/response'
require 'recursive-open-struct'
require 'wlc/configuration'
require 'wlc/resources/resource'
require 'wlc/resources/product'
require 'wlc/resources/order'

module Wlc
  class << self
    extend Forwardable
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
      build_api
    end

    def build_api
      token = Token.new
      @api = Api.new(Client.new(token))
    end

    def_delegators :@api, :products, :order
  end
end
