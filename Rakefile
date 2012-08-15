$: << 'lib'

desc 'build the .gem file from gemspec'
task :build do
  sh 'gem build ./reuser.gemspec'
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

desc 'release the gem'
task :release => [:build, :push]

desc 'run the specs'
task :spec do
  sh 'rspec --color --format=nested'
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = '--color'
end

task :default => [:spec, :features]
