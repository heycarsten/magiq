# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'magiq/version'

Gem::Specification.new do |spec|
  spec.name          = 'magiq'
  spec.version       = Magiq::VERSION
  spec.authors       = ['Carsten Nielsen']
  spec.email         = ['heycarsten@gmail.com']

  spec.summary       = %q{Magically turn query parameters into ActiveRecord scopes}
  spec.description   = %q{Magiq enables you to declaratively specifiy queries that translate into ActiveRecord Arel scopes}
  spec.homepage      = 'https://github.com/heycarsten/magiq'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 4.1'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
