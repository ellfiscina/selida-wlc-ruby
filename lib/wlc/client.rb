module Wlc
  class Client
    attr_accessor :token

    def initialize(token)
      @token = token
    end

    def self.host
      'http://www.selida.com.br'
    end

    def get(path, params = {})
      request.get path, params.merge(keyword_token)
    end

    def post(path, resource = {})
      request.post request_path(path, keyword_token[:keyword]), resource
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

    def request_path(path, keyword)
      path + "?Keyword=#{keyword}"
    end
  end
end
