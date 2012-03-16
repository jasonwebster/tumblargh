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

    def render_file(file, blog)
      render(:file, file, blog)
    end

    def render_html(string, blog)
      render(:html, string, blog)
    end

    private

    def render(setter, theme, blog)
      parser = Parser.new
      parser.send(setter, theme)
      blog = API::Blog.new(blog)
      config = parser.extract_config

      Renderer::Document.new(parser.parse, blog, config).render
    end

  end

end
