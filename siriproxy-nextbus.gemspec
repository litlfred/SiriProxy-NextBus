# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "siriproxy-nextbus"
  s.version     = "0.0.1" 
  s.authors     = ["litlfred"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = %q{Get Next Bus Information for Chapel Hill}
  s.description = %q{Queries against http://www.nextbus.com to get the next bus}

  s.rubyforge_project = "siriproxy-nextbus"

  s.files         = `git ls-files 2> /dev/null`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/* 2> /dev/null`.split("\n")
  s.executables   = `git ls-files -- bin/* 2> /dev/null`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for hello:
  # s.add_development_dependency "rspec"
  s.add_dependency "nokogiri"
end


