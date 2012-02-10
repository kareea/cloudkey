require 'curb'

require 'cloudkey/version'
require 'cloudkey/security_level'
require 'cloudkey/security_policy'
require 'cloudkey/api'

module Cloudkey
  @@verbose = false

  def self.authenticate *args
    API::new *args
  end

  def self.verbose= b
   @@verbose = b
  end

  def self.verbose?
    @@verbose
  end
end
