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
  s.rdoc_options = ["--line-numbers", "--main", "README.md"]
  s.extra_rdoc_files = ["README.md"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "webmock", "~> 1.6.4"
  s.add_development_dependency "vcr", "~> 1.10.3"
  s.add_dependency 'curb', "~> 0.7.15"
end
