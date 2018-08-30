module Wlc
  class Request
    API_ENDPOINT = '/apiintegracao/ExternaEcommerce/api'

    attr_accessor :connection

    def initialize(client)
      @connection = Faraday.new(url: Client.host) do |builder|
        builder.headers['Content-Type'] = 'application/json'
        builder.headers['Authorization'] = Auth.new(client).header
        builder.adapter Faraday.default_adapter
      end
    end

    def get(url, params = {})
      Response.new connection.get(request_path(url), params)
    end

    def post(url, resource = {})
      Response.new connection.post(request_path(url), resource_to_post(resource))
    end

    private

    def resource_to_post(resource)
      serialize_resource_keys(resource).to_json
    end

    def serialize_resource_keys(hash)
      hash.to_snake_keys.to_camel_keys
    end

    def request_path(url)
      API_ENDPOINT + url
    end
  end
end
