module Wlc
  class Client
    attr_accessor :token

    def initialize(token)
      @token = token
    end

    def self.host
      case Wlc.configuration.environment
      when :sandbox
        'http://www.selida.com.br'
      when :production
        'http://www.selida.com.br'
      else
        raise StandardError, 'invalid environment provided'
      end
    end

    def get(path, params = {})
      request.get path, params.merge(keyword_token)
    end

    def post(path, resource = {})
      request.post path, resource.merge(keyword_token)
    end

    private

    def request
      Request.new(self)
    end

    def keyword_token
      @keyword_token ||= { keyword: token.access_keyword }
    end

    def new_token
      self.token = token.refresh
    end
  end
end
