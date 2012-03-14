Gem::Specification.new do |s|
  s.name        = 'tumblargh'
  s.version     = '0.0.0'
  s.date        = '2012-03-11'
  s.summary     = ''
  s.description = ''
  s.authors     = ['Jason Webster']
  s.email       = 'jason@metalabdesign.com'
  s.homepage    = 'http://rubygems.org/gems/hola'

  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'

  s.add_dependency('activesupport', '~> 3.2')
end