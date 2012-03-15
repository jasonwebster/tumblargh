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

    def render(template_file, blog)
      template = Parser.new(template_file)
      blog = API::Blog.new(blog)
      config = template.extract_config

      Renderer::Document.new(template.parse, blog, config).render
    end

    def render_html(string, blog)
      template = Parser.new
      template.html = string

      blog = API::Blog.new(blog)
      config = template.extract_config

      Renderer::Document.new(template.parse, blog, config).render
    end

  end

end
