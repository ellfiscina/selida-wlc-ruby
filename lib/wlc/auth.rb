module Wlc
  class Auth
    attr_accessor :client

    def initialize(client)
      @client = client
    end

    def header
      "bearer #{client.current_token.access_token}"
    end
  end
end
