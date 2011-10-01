require 'rake'

spec = Gem::Specification.new do |s|
  s.name = 'reuse'
  s.version = '0.0.0'
  s.summary = 'An internal DSL for Ruby to make user role management simple.'
  s.description = s.summary
  s.author = 'Isaac Sanders'
  s.homepage = 'http://isaacsanders.github.com/reuse'
  s.email = 'isaacsanders@gmail.com'
  s.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*'].to_a
  s.test_files = Dir.glob('test/**/*.rb')
end
