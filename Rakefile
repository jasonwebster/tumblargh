require 'rubygems'
require 'bundler/setup'

require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end

desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
end


desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r tumblargh.rb"
end


require 'jeweler'
Jeweler::Tasks.new do |s|
  s.name        = 'tumblargh'
  s.summary     = 'Groan-less Tumblr theme development.'
  s.description = `cat README.md`
  s.authors     = ['Jason Webster']
  s.email       = 'jason@metalabdesign.com'
  s.homepage    = 'http://github.com/jasonwebster/tumblargh'

  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'
end

Jeweler::RubygemsDotOrgTasks.new



