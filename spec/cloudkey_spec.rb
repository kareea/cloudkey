require 'spec_helper'

describe Cloudkey do
  context "Public API" do
    #use_vcr_cassette

    it "should provide an authenticate method on Cloudkey" do
      Cloudkey.should respond_to :authenticate
    end

    it "should count medias" do
      @cloudkey = Cloudkey.authenticate "4cad8cc994a6f66a9d000001", "e873406200f136c54b07acac615ec802bcc043e7"
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
