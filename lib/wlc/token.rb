module Wlc
  class Token
    attr_accessor :valid_token

    def initialize
      @valid_token = generate_new_token
    end

    def inspect
      "#<#{self.class.name}:#{object_id}>"
    end

    def access_token
      valid_token['obj_return'][:token]
    end

    def access_keyword
      valid_token['obj_return'][:keyword]
    end

    def refresh
      self.valid_token = generate_new_token
      self
    end

    private

    def token_host
      Client.host + '/apiintegracao/ExternaEcommerce/api/Account/Login'
    end

    def token_grants
      { UserName: Wlc.configuration.username,
        Password: Wlc.configuration.password }
    end

    def generate_new_token
      connection = Faraday.new(url: token_host)
      response = connection.post do |request|
        request.headers['Content-Type'] = 'application/json'
        request.body = token_grants.to_json
      end
      Response.new(response)
    end
  end
end
