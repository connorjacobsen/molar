# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'molar/version'

Gem::Specification.new do |spec|
  spec.name          = 'molar'
  spec.version       = Molar::VERSION
  spec.authors       = ['Connor Jacobsen']
  spec.email         = ['jacobsen.connor@gmail.com']

  spec.summary       = 'Mixin for attribute hash lookups.'
  spec.description   = 'Dynamically defines attribute hash accessors and mutators.'
  spec.homepage      = 'https://github.com/connorjacobsen/molar'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rspec-its', '~> 1.2'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'simplecov', '~> 0.10'
end
