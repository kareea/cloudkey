module Cloudkey
  class File < Client
    def upload_file path
      raise "File not found" unless File.exists? path
      
      @curl = curl   
      @curl.multipart_form_post
    
      @curl.http_post Curl::PostField.file(path)
      JSON.parse curl.body_str
    end
  end
end