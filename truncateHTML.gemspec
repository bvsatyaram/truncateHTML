# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "truncateHTML/version"

Gem::Specification.new do |s|
  s.name        = "truncateHTML"
  s.version     = Truncatehtml::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Satyaram B V"]
  s.email       = ["bvsatyaram AT gmail DOT com"]
  s.homepage    = "http://bvsatyaram.com"
  s.summary     = %q{Truncate HTML without breaking HTML tags, entities, and optionally words}
  s.description = %q{Truncate HTML without breaking HTML tags, entities, and optionally words}

  s.add_dependency "hpricot"

  s.rubyforge_project = "truncateHTML"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
