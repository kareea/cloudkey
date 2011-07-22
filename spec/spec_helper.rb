require 'vcr'
require 'cloudkey'
require 'credentials' # used to record cassettes

VCR.config do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.stub_with :webmock
  #c.default_cassette_options = {:record => :once}
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end

