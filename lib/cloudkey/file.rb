module Cloudkey
  class File < Client
    def upload_file path, &block
      raise "File not found" unless ::File.exists? path

      curl(fetch_upload_url) do |c|
        c.multipart_form_post = true
        c.headers             = false
        c.follow_location     = true
        if block_given?
          c.on_progress  do |dl_total, dl_now, ul_total, ul_now|
            block.call(ul_now, ul_total) if ul_total > 0.0
            true
          end
        end

        c.http_post Curl::PostField.file("file", path)
        JSON.parse c.body_str
      end
    end

    protected

    def fetch_upload_url
      upload["result"]["url"]
    end
  end
end
