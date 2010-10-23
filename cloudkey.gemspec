# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cloudkey/version"

Gem::Specification.new do |s|
  s.name        = "cloudkey"
  s.version     = Cloudkey::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jean-Hadrien Chabran", "Boubacar Diallo"]
  s.email       = ["jh@kareea.com"]
  s.homepage    = "http://rubygems.org/gems/cloudkey"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "cloudkey"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec", "~> 2.0.1"
  s.add_dependency 'curb', "~> 0.7.8"
end
