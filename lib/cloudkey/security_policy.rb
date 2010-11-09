require "cgi"
require "base64"
require "zlib"

module Cloudkey
  class SecurityPolicy
    IP_FORMAT_ERROR       = Class.new(Exception)
    REFERERS_FORMAT_ERROR = Class.new(Exception)
    
    def initialize opts={}
      @options = {:expires_in => 7200}.merge(opts)
    end    
      
    def method_missing method_id, *args, &block
      method_id = method_id.to_s
      
      affectation = method_id.include? "="
      method_id.gsub!("=",'')
      
      if affectation
        @options[method_id.to_sym] = args.first
      end
        
      @options[method_id.to_sym]
    end
    
    def expires
      @options[:expires_in] + Time.now.tv_sec
    end
  
    def none?
      @options.empty? || @options.keys == [:expires_in]
    end
    
    def delegate?
      @options[:delegate]
    end
    
    def as_number?
      !!@options[:as_number]
    end
    
    def ip?
      if @options[:ip]
        raise IP_FORMAT_ERROR unless @options[:ip].match(/\b(?:\d{1,3}\.){3}\d{1,3}\b/)
        true
      end
    end
    
    def user_agent?
      @options[:user_agent] && !@options[:user_agent].empty?
    end
    
    def use_once?
      @options[:use_once]
    end
    
    def countries?
      @options[:countries] && !@options[:countries].empty?
    end
    
    def referers?
      if @options[:referers] && !@options[:referers].empty?
        raise REFERERS_FORMAT_ERROR unless @options[:referers].inject(true) { |result, url| result && url.match(/https?:\/\/(.*)/) }
        true
      end
    end
    
    def set opts={}
      @options = opts
    end
    
    def private_parameters
      parameters = []
      parameters << as_number if as_number?
      parameters << ip if ip?
      parameters << user_agent if user_agent?
      parameters 
    end

    def public_parameters
      parameters = []
      parameters << "cc=#{countries.collect{|c| c.downcase}.join(',')}" if countries?
      parameters << "rf=#{CGI.escape(referers.collect{|r| r.gsub(' ', '%20')}.join(' '))}" if referers?
      parameters unless parameters.empty?
    end
    
    def encoded_public_parameters
      Base64.encode64(Zlib::Deflate.deflate(public_parameters.join('&'))).chomp if public_parameters
    end
    
    def level
      result = 0
      API::SecurityLevel.constants.each do |constant|
        result |= API::SecurityLevel.const_get(constant) if send("#{constant.to_s.downcase}?")
      end
      result
    end
  end
end