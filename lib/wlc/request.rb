module Wlc
  class Request
    API_ENDPOINT = '/apiintegracao/ExternaEcommerce/api'

    attr_accessor :connection

    def initialize(client)
      @connection = Faraday.new(url: Client.host) do |builder|
        builder.headers['Content-Type'] = 'application/json'
        builder.headers['Authorization'] = Auth.new(client).header
        builder.adapter Faraday.default_adapter
        builder.options[:timeout] = Wlc.configuration.timeout
      end
    end

    def get(url, params = {})
      watch_timeout(url) do
        Response.new connection.get(request_path(url), params)
      end
    end

    def post(url, resource = {})
      watch_timeout(url) do
        Response.new connection.post(request_path(url), resource_to_post(resource))
      end
    end

    private

    def watch_timeout(url)
      start_time = Time.now.to_f
      yield if block_given?
    rescue Faraday::TimeoutError
      seconds = (Time.now.to_f - start_time).to_i
      raise TimeoutError, "The following address took longer than #{seconds}s to reply: '#{Client.host + url}'"
    end

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
