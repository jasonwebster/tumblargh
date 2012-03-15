# Using for version parsing
require 'rubygems'

module Tumblargh
  VERSION = '0.0.0' unless const_defined?(:VERSION)
  GEM_VERSION = ::Gem::Version.create(VERSION) unless const_defined?(:GEM_VERSION)
end
