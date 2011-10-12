require 'rake'

spec = Gem::Specification.new do |s|
  s.name = 'reuser'
  s.version = '0.2.0'
  s.summary = 'An internal DSL for Ruby to make user role management simple.'
  s.description = 'ReUse is an Internal DSL for Ruby to create roles and manage actions.'
  s.author = 'Isaac Sanders'
  s.homepage = 'http://isaacsanders.github.com/reuser'
  s.email = 'isaacsanders@gmail.com'
  s.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'spec/**/*'].to_a
  s.test_files = Dir.glob('spec/**/*.rb')
end
