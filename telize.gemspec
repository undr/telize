# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'telize/version'

Gem::Specification.new do |spec|
  spec.name          = 'telize'
  spec.version       = Telize::VERSION
  spec.authors       = ['undr']
  spec.email         = ['undr@yandex.ru']
  spec.summary       = %q{A ruby client for Telize geoip service.}
  spec.description   = %q{A ruby client for Telize geoip service.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'multi_json'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
