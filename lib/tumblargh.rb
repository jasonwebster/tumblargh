require 'active_support'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/string/conversions'
require 'active_support/core_ext/time/conversions'
require 'active_support/inflector'

require 'tumblargh/version'

module Tumblargh

  autoload :API,       'tumblargh/api'
  autoload :Parser,    'tumblargh/parser'
  autoload :Node,      'tumblargh/node'
  autoload :Renderer,  'tumblargh/renderer'

  class << self

    attr_accessor :config

    def render_file(file, blog, options={})
      render(:file, file, blog)
    end

    def render_html(string, blog, options={})
      render(:html, string, blog, options)
    end

    private

    def render(setter, theme, blog, options)
      if API.api_key.nil? or not defined?(API.api_key)
        raise "Need to specify a Tumblr API key for Tumblargh"
      end

      parser = Parser.new
      parser.send("#{setter}=", theme)
      blog = API::Blog.new(blog)

      options = parser.options.merge(options)

      Renderer::Document.new(parser.tree, blog, options).render
    end

  end

end
