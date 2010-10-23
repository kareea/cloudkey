require 'curb'

require 'cloudkey/version'
require 'cloudkey/security_level'
require 'cloudkey/api'

module Cloudkey
  def self.authenticate *args
    API::new *args
  end
end
