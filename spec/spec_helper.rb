require 'cloudkey'
require 'vcr'

TEST_USER_ID  = ""
TEST_USER_KEY = ""

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end
