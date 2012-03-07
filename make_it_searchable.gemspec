# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "make_it_searchable/version"

Gem::Specification.new do |s|
  s.name        = "make_it_searchable"
  s.version     = MakeItSearchable::VERSION
  s.authors     = ["KunHa"]
  s.email       = ["potato9@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{simple column filtering and sorting}
  s.description = %q{simple column filtering and sorting}

  s.rubyforge_project = "make_it_searchable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec"
  s.add_development_dependency "activerecord"
  s.add_development_dependency "guard"
end
