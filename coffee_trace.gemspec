# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "coffee_trace/version"

Gem::Specification.new do |gem|
  gem.name        = "coffee_trace"
  gem.authors     = ["Chris Aitchison"]
  gem.email       = ["cmaitchison@gmail.com"]
  gem.homepage    = "http://github.com/cmaitchison/coffee_trace"
  gem.summary     = %q{Add and remove trace logging to coffeescript}
  gem.description = %q{Add and remove trace logging to coffeescript}

  gem.version     = CoffeeTrace::VERSION
  gem.platform    = Gem::Platform::RUBY

  gem.add_runtime_dependency("thor", "~> 0.14.6")
  gem.add_development_dependency("rspec", "~> 2.6.0")

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
end
