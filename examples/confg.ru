#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

require 'tumblargh'

Tumblargh::API::set_api_key 'YOUR_TUMBLR_API_KEY'

map "/" do

  app = proc do |env|
    html = Tumblargh::render_file('my_theme.html', 'willw.tumblr.com')

    [200, { "Content-Type" => "text/html" }, html.lines]
  end

  run app
end
