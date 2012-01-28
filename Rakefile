desc 'build the .gem file from gemspec'
task :build do
  sh 'gem build reuser.gemspec'
end

desc 'install the gem from .gem file'
task :install do
  sh 'gem install reuser-*.gem'
end

desc 'push the gem to rubygems.org'
task :push do
  sh 'gem push reuser-*.gem'
end

desc 'make (build and install the gem from gemspec)'
task :make => [:build, :install]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color --format=nested'
end

task :default => :spec
