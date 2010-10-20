require 'spec_helper'

describe Cloudkey do
  context "Public API" do
    it "should provide an authenticate method on Cloudkey" do
      Cloudkey.should respond_to :authenticate
    end
    
    it "should count medias" do
      pending
      @cloudkey = Cloudkey.authenticate "foo", "bar"
      @cloudkey.media.count
    end
    
    it "should accept an optional proxy" do
      @proxy = "http://my.awesome.proxy.com:3128"
      Cloudkey.authenticate("foo", "bar", :proxy => @proxy).proxy.should == @proxy
    end
    
    it "should accept an optional base_url" do
      @base_url = "http://different.api.dmcloud.net"
      Cloudkey.authenticate("foo", "bar", :base_url => @base_url).base_url.should == @base_url
    end
  end
end