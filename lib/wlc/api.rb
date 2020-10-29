module Wlc
  class Api
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def products
      Wlc::Resources::Product.new(client)
    end

    def order
      Wlc::Resources::Order.new(client)
    end

    def available?
      client.token.valid?
    end
  end
end
