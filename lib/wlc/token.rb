module Wlc
  class Token
    MINUTES = 10
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

    def expired?
      (Time.now.utc - @expires_at) >= 0
    end

    def valid?
      success = valid_token.success if valid_token.respond_to?(:success)
      success == true
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
      @expires_at = Time.now + (MINUTES * 60)
      connection = Faraday.new(url: token_host)
      response = connection.post do |request|
        request.headers['Content-Type'] = 'application/json'
        request.body = token_grants.to_json
        request.options[:timeout] = 3
      end
      Response.new(response)
    rescue Faraday::Error
    end
  end
end
