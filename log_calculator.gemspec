# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "log_calculator/version"

Gem::Specification.new do |s|
  s.name        = "log_calculator"
  s.version     = LogCalculator::VERSION
  s.authors     = ["dogenpunk"]
  s.email       = ["dogenpunk@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Calculate costs based on Rate and Time}
  s.description = s.summary

  s.rubyforge_project = "log_calculator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~> 2.7"
  s.add_development_dependency "simplecov", "~> 0.5"
  s.add_development_dependency "rake", "~> 0.9"
  s.add_development_dependency "ZenTest"
  s.add_runtime_dependency "money", "~> 3.7"
end
