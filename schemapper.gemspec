# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schemapper/version'

Gem::Specification.new do |spec|
  spec.name          = "schemapper"
  spec.version       = Schemapper::VERSION
  spec.authors       = ["Nathaniel Wroblewski"]
  spec.email         = ["nathanielwroblewski@gmail.com"]
  spec.description   = %q{Visualize your Rails schema}
  spec.summary       = %q{Database agnostic visualization of your Rails schema}
  spec.homepage      = "https://github.com/NathanielWroblewski/schemapper"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
