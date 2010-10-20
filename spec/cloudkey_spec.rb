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
  end
end