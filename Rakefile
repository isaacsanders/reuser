require "bundler/gem_tasks"

task :spec do
  sh 'rspec --color --format=nested'
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = '--color'
end

task :default => [:spec, :features]
