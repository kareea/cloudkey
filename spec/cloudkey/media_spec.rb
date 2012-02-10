describe Cloudkey::Media do
  use_vcr_cassette

  context "Using test account" do
    before :each do
      @cloudkey = Cloudkey.authenticate TEST_USER_ID, TEST_USER_KEY
    end

    context "Having a collection" do
      it "should list four medias" do
        @cloudkey.media.list(:fields => [:id], :per_page => 20)['result']['total'].should ==(4)
      end

      it "should get all the titles" do
        @cloudkey.media.list(:fields => [:"meta.title"], :per_page => 20)['result']['list'].collect do |item|
          item['meta']['title']
        end.should have(4).items
      end
    end

    context "Querying a single media" do
      it "should have an embedded url" do
        @cloudkey.media.embedded_url('4f33ddbc94a6f6517c001577').should include("http://api.dmcloud.net/embed/4f33d9c8f325e11c830016af/4f33ddbc94a6f6517c001577")
      end

      it "should have a stream url" do
        @cloudkey.media.stream_url('4f33ddbc94a6f6517c001577').should include("http://cdn.dmcloud.net/route/4f33d9c8f325e11c830016af/4f33ddbc94a6f6517c001577/mp4_h264_aac.mp4")
      end

      it "should have http detected as protocol" do
        @cloudkey.media.stream_url('4f33ddbc94a6f6517c001577', 'mp4_h264_aac',Cloudkey::SecurityPolicy.new, :download => true).should include("/http/")
      end
    end
  end
end
