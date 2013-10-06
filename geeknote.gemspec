# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geeknote/version'

Gem::Specification.new do |spec|
  spec.name          = "geeknote"
  spec.version       = Geeknote::VERSION
  spec.authors       = ["Ma Lucheng"]
  spec.email         = ["mlc880926@gmail.com"]
  spec.description   = %q{geeknote ruby clone}
  spec.summary       = %q{geeknote ruby clone}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
