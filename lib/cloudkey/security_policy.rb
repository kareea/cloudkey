module Cloudkey
  class SecurityPolicy < Hash
    IP_FORMAT_ERROR       = Class.new(Exception)
    REFERERS_FORMAT_ERROR = Class.new(Exception)
    
    def initialize opts={}
      replace({:expires => 7200}).merge(opts)
    end    
      
    def method_missing method_id, *args, &block
      method_id = method_id.to_s
      
      affectation = method_id.include? "="
      method_id.gsub!("=",'')
      
      if affectation
        send(:[]=, method_id.to_sym, *args)
      else
        send(:[], method_id.to_sym, *args)
      end
    end
  
    def none?
      empty? || keys == [:expires]
    end
    
    def delegate?
      self[:delegate]
    end
    
    def as_number?
      !!self[:as_number]
    end
    
    def ip?
      if self[:ip]
        raise IP_FORMAT_ERROR unless self[:ip].match(/\b(?:\d{1,3}\.){3}\d{1,3}\b/)
      end
    end
    
    def user_agent?
      self[:user_agent] && !self[:user_agent].empty?
    end
    
    def use_once?
      self[:use_once]
    end
    
    def countries?
      self[:countries] && !self[:countries].empty?
    end
    
    def referers?
      if self[:referers] && !self[:referers].empty?
        raise REFERERS_FORMAT_ERROR unless self[:referers].inject(true) { |result, url| result && url.match(/https?:\/\/(.*)/) }
      end
    end
    
    def set opts={}
      replace opts
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