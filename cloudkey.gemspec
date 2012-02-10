# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cloudkey/version"

Gem::Specification.new do |s|
  s.name        = "cloudkey"
  s.version     = Cloudkey::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jean-Hadrien Chabran", "Boubacar Diallo"]
  s.email       = ["jh@kareea.com"]
  s.homepage    = "http://github.com/kareea/cloudkey"
  s.summary     = %q{Client library to access DailymotionCloud services}
  s.description = %q{Client library to access DailymotionCloud services}

  s.rubyforge_project = "cloudkey"
  s.rdoc_options = ["--line-numbers", "--main"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "webmock", "~> 1.7.10"
  s.add_development_dependency "vcr", "~> 2.0.0.rc1"
  s.add_development_dependency "rake"
  s.add_dependency 'curb', "~> 0.8.0"
end
