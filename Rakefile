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

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color --format=nested'
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = '--color'
end

namespace :features do
  desc 'runs features tagged as @focus'
  Cucumber::Rake::Task.new(:focus) do |t|
    t.cucumber_opts = '--color --tag @focus'
  end
end

require 'flay_task'

FlayTask.new do |t|
  t.dirs = %w{lib}
end


require 'flog_task'

FlogTask.new do |t|
  t.dirs = %w{lib}
end

task :default => [:spec, :features]
