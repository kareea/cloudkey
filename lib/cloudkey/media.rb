module Cloudkey
  class Media < Client
    CDN_URL = 'http://cdn.dmcloud.net'
    STATIC_URL = 'http://static.dmcloud.net'
    PROTOCOLS = %w(hls rtmp hps http)

    ProtocolError = Class.new(Exception)

    def embedded_url id, security_level = SecurityPolicy.new
      url = "#{@api.base_url}/embed/#{@api.user_id}/#{id}"
      API.sign_url url, @api.key, security_level
    end

    def stream_url id, asset_name="mp4_h264_aac", security_level=SecurityPolicy.new, opts={}
      opts = normalize_opts(opts)

      # Switch to static cdn for thumbnails
      if asset_name.match(/^jpeg_thumbnail/)
        opts[:cdn_url] = STATIC_URL

        ts = "-#{opts[:expires_in]}" if opts[:expires_in]

        url = "#{opts[:cdn_url]}/#{@api.user_id}/#{id}/#{asset_name}/#{ts}/#{version}"
        return url
      end

      extension = asset_name.split('_')[0]
      extension = "f4m" if extension == 'f4f'

      url = "#{opts[:cdn_url]}"
      url << "/route"
      url << "/#{opts[:protocol]}" if opts[:protocol] != ''
      url << "/#{@api.user_id}/#{id}/#{asset_name}#{opts[:version]}.#{extension}"

      API.sign_url url, @api.key, security_level
    end

    private
    def normalize_opts opts
      opts = {
        :cdn_url  => CDN_URL,
        :protocol => ''
      }.merge(opts)

      # Raise an exception if unsupported protocol is used
      raise ProtocolError if opts[:protocol] != '' && !PROTOCOLS.include?(opts[:protocol])

      # Normalize version
      opts[:version] = "-#{opts[:version]}" if opts[:version]


      # Force http in these cases
      if opts[:download] || opts[:filename]
        opts[:protocol] = 'http'
      end

      opts
    end
  end
end
