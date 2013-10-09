# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tumblargh/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'tumblargh'
  s.version     = Tumblargh::VERSION
  s.license     = 'MIT'
  s.summary     = 'Groan-less Tumblr theme development.'
  s.description = "Tumblargh aims to reduce suffering involved with building a theme by offering a way to fully develop, lint and test Tumblr themes locally, with real posts from any existing Tumblog."
  s.authors     = ['Jason Webster']
  s.email       = 'jason@metalabdesign.com'
  s.homepage    = 'http://github.com/jasonwebster/tumblargh'

  s.files        = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'activesupport', '>= 3.1'
  s.add_dependency 'api_cache'
  s.add_dependency 'nokogiri'
  s.add_dependency 'treetop'

  s.add_development_dependency 'autotest-standalone'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
end

