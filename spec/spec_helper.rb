require 'rspec'
require 'open-uri'

# if something??!
#   require 'simplecov'
#   SimpleCov.start
# end

$: << File.dirname(__FILE__) + '/../lib'

require 'tumblargh'

FIXTURE_PATH = File.join(File.dirname(__FILE__), 'fixtures')
TUMBLR_API_KEY = '8QoLnQy4lP0rn6QHNYSDxmhZo0L6xelNmNosAVj703FNfLBhZQ'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
  config.color_enabled = true

end
