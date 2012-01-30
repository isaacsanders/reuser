require "rake"
require_relative "version"

spec = Gem::Specification.new do |s|
  s.name = "reuser"
  s.version = ReUser::VERSION
  s.summary = "An internal DSL for Ruby to make user role management simple."
  s.description = "ReUse is an Internal DSL for Ruby to create roles and manage actions."
  s.author = "Isaac Sanders"
  s.homepage = "http://isaacbfsanders.com/reuser"
  s.email = "isaac@isaacsanders.com"
  s.files = FileList["lib/**/*.rb"].to_a
  s.test_files = Dir.glob("spec/**/*.rb")
end
