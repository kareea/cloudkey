require 'json'

module Cloudkey
  class Client
    def initialize api
      @api = api
    end
    
    def method_missing method_id, *args, &block
      call(method_id, *args, &block)
    end
    
    protected
    def call method, args={}
      @request = create_request self.class.name.gsub("Cloudkey::",'').downcase, method, args
      authenticate_request @request
      
      curl.http_post @request.to_json
      
      JSON.parse curl.body_str
    end
    
    def authenticate_request request
      request[:auth] = "#{@api.user_infos}:#{API::sign(@api.user_infos + API.normalize(request), @api.key)}"
    end
    
    def curl
      @curl ||= Curl::Easy.new @api.target do |c|
        c.useragent               = "cloudkey-rb #{Cloudkey::VERSION}"
        c.headers['Content-Type'] = "application/json"
        c.proxy_url               = @api.proxy if @api.proxy
      end
    end
    
    def create_request name, method, args
      {
        :call => "#{name}.#{method}",
        :args => args
      }
    end
  end
end