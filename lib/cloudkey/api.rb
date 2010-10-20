require 'cloudkey/client'

require 'cloudkey/file'
require 'cloudkey/media'

module Cloudkey
  class API
    attr_accessor :user_id, :key, :base_url, :proxy, :act_as_user
    
    # New API versions that break compatibility would probably change the endpoint
    END_POINT = "/api"
    
    def initialize user_id, key, options={}
      raise "Can't connect without an user_id" unless user_id
      raise "Can't connect without an key" unless key
      
      @user_id, @key = user_id, key
      
      @base_url = options[:base_url] || 'http://api.dmcloud.net'
      @proxy = options[:proxy]
      @act_as_user = options[:act_as_user]
      
      @target = @base_url + END_POINT
    end
    
    def user_infos
      if act_as_user
        "#{user_id}/#{act_as_user}"
      else
        user_id
      end
    end
    
    def media
      Media.new self 
    end
    
    def file
      File.new self
    end
    
    def self.normalize payload
      case payload
      when Array
        payload.collect { |element| normalize element }.join('')
      when Hash
        payload.to_a.sort { |a,b| a.first <=> b.first }.collect {|array| array.first.to_s + normalize(array.last)}.join('')
      else
        payload.to_s
      end
    end
  end
end