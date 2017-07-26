# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'goflippy-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'goflippy-ruby'
  spec.version       = GoFlippy::VERSION
  spec.authors       = ['neko-neko']
  spec.email         = ['seiichi.nishikata456@gmail.com']
  spec.summary       = 'Goflippy Ruby SDK'
  spec.homepage      = 'https://github.com/neko-neko/goflippy-ruby'
  spec.license       = 'MIT'
  spec.require_paths = ['lib']
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.add_dependency 'concurrent-ruby', '~> 1.0.5'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.6.0'
  spec.add_development_dependency 'rubocop', '~> 0.49.1'

  spec.required_ruby_version = '>= 2.3.0'
end
