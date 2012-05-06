# Tumblargh
## Groan-less Tumblr theme development

### What is this thing, and why should I care?

If you've ever had to build a Tumblr theme, you've probably cried out in pain 
while tweaking locally, copying, pasting into the theme editor, saving, switching
tabs and finally refreshing and waiting for your tesing blog to reload.

Tumblargh aims to reduce suffering involved with building a theme by offering 
a way to fully develop, lint and test Tumblr themes locally, with real posts 
from any existing Tumblog.

### Getting Started

You'll need to get an OAuth consumer key for the Tumblr v2 API to use remote data
with Tumblargh. Registration is simple enough, just go to http://www.tumblr.com/oauth/apps
and fill out the form. Any time Tumblargh asks for your API key, it'll be the 
OAuth Consumer key provided there.

#### Middleman

The recommended way to use tumblargh is in conjuction with 
[Middleman](http://middlemanapp.com/).

> Middleman is a static site generator based on Sinatra. Providing dozens of 
templating languages (Haml, Sass, Compass, Slim, CoffeeScript, and more).

Tumblargh includes a simple Middleman extension that turns any Middleman project
into a local Tumblr theme building machine.

Tumblargh will automatically parse any html files served by Middleman, and 
populate them with content from the Tumblr of your choosing. It will not
parse any HTML during Middleman's build process. The output of`middleman build` 
is ready for use on your blog, or submission to the Tumblr theme store.

To get up an running with Middleman, first create a new Middleman project:

```
$ middleman init MY_PROJECT_NAME
```

If one does not already exist, create a Gemfile and add the following as needed:

```ruby
source "http://rubygems.org"

gem 'middleman'
gem 'tumblargh', :git => 'git://github.com/jasonwebster/tumblargh.git'
```

Note that there has not yet been an official release of tumblargh to RubyGems,
so currently, specifying the gem via git is necessary.

Run `bundle install`.

The bare minimum setup in your Middleman config.rb is:

```ruby
require 'tumblargh'
require 'middleman/features/tumblargh'

activate :tumblargh

set_tumblr_api_key 'API KEY' # This is your OAuth consumer key
set_tumblr_blog 'staff.tumblr.com'
```

It is highly recommended to run the Middleman server via `bundle exec`.

#### Rack

See `examples/config.ru` for a minimal Rack setup, ready to go with `rackup` or
your Ruby server of choice.

### Known issues & planned features

- Separate Tumblr resources (i.e. Blog, Posts, etc) from the API wrapper, so
  we can locally define data, or save API responses for test fixtures.



