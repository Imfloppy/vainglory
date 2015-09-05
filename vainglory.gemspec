# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vainglory/version'

Gem::Specification.new do |spec|
  spec.name          = "vainglory"
  spec.version       = Vainglory::VERSION
  spec.authors       = ["matthew70", "mitsuru793"]
  spec.email         = ["smatthew7000@gmail.com", "mitsuru793@gmail.com"]

  spec.summary       = %q{Ruby wrapper for the Vainglory}
  spec.description   = %q{Ruby wrapper for the Vainglory}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "nokogiri"
end
