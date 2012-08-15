# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reuser/version'

Gem::Specification.new do |gem|
  gem.name          = "reuser"
  gem.version       = ReUser::VERSION
  gem.authors       = ["Isaac Sanders"]
  gem.email         = ["isaac@isaacbfsanders.com"]
  gem.description   = %q{ReUser is a DSL for Ruby to create roles and manage actions.}
  gem.summary       = %q{An internal DSL for Ruby to make user role management simple.}
  gem.homepage      = "http://isaacbfsanders.com/reuser"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
