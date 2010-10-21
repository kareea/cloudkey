module Cloudkey
  class Client
    def initialize api
      @api = api
    end
    
    protected
    def call method, args={}
      @request = create_request self.class.name.downcase, method, args
    end
    
    def authenticate_request request
      request[:auth] = "#{@api.user_infos}:#{API::sign(user_infos)}"
      
      
    end
    
    def create_request name, method, args
      {
        :call => "#{name}.#{method}",
        :args => args
      }
    end
  end
end