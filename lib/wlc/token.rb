module Wlc
  class Token
    attr_accessor :valid_token

    def initialize
      @valid_token = generate_new_token
    end

    def inspect
      "#<#{self.class.name}:#{object_id}>"
    end

    def expires_at
      Time.parse(valid_token['.expires'])
    end

    def access_token
      valid_token['Token']
    end

    def access_keyword
      valid_token['Keyword']
    end

    def refresh
      self.valid_token = generate_new_token
      self
    end

    def expired?
      (Time.now.utc - expires_at) >= 0
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
        request.body = URI.encode_www_form(token_grants)
      end
      Response.new(response)
    end
  end
end
