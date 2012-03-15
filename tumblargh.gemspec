Gem::Specification.new do |s|
  s.name        = 'tumblargh'
  s.version     = '0.0.0'
  s.date        = '2012-03-11'
  s.summary     = 'Groan-less Tumblr theme development.'
  s.description = `cat README.md`
  s.authors     = ['Jason Webster']
  s.email       = 'jason@metalabdesign.com'
  s.homepage    = 'http://github.com/jasonwebster/tumblargh'

  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'

  s.add_dependency('treetop')
  s.add_dependency('nokogiri')
  s.add_dependency('activesupport', '> 3.1')
end
