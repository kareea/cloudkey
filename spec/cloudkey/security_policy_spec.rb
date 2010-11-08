require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Cloudkey
  describe SecurityPolicy do
    before(:each) do
      @policy = SecurityPolicy.new
    end
    
    describe "Default behavior" do  
      it "should default to no policy" do
        @policy.should be_none
        @policy.expires.should == 7200
      end
    end
    
    describe "IP" do
      it "should accept an IP" do
        @policy.ip = "192.168.0.3"
        (@policy.level & API::SecurityLevel::IP).should be_true
      end
      
      it "should accept an IP and a user agent" do
        @policy.set :ip => "192.168.0.1", :user_agent => "Mammouth Browser v0.1"
        (@policy.level & API::SecurityLevel::IP).should be_true
        (@policy.level & API::SecurityLevel::USER_AGENT).should be_true
      end
      
      it "should raise an error on bad ip format" do
        @policy.set :ip => "Bob Kelso"
        -> {@policy.level}.should raise_error(SecurityPolicy::IP_FORMAT_ERROR)
      end
    end

    describe "Referers" do
      it "should accept referers" do
        @policy.referers =  %w(http://google.com http://lolcat.com)
        (@policy.level & API::SecurityLevel::REFERERS).should be_true  
      end
      
      it "should accept only valid refers" do
        @policy.referers =  ["http://google.com", ""]
        -> { @policy.level }.should raise_error(SecurityPolicy::REFERERS_FORMAT_ERROR)
      end      
    end
    
    describe "Expires" do
      it "should accept an expire time" do
        @policy.expires = 5000
        @policy[:expires].should be(5000)
      end
    end
  end    
end