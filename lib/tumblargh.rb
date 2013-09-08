require 'active_support'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/string/conversions'
require 'active_support/core_ext/time/conversions'
require 'active_support/inflector'
require 'tumblargh/version'

module Tumblargh

  autoload :API,       'tumblargh/api'
  autoload :Node,      'tumblargh/node'
  autoload :Parser,    'tumblargh/parser'
  autoload :Renderer,  'tumblargh/renderer'
  autoload :Resource,  'tumblargh/resource'

  class << self

    attr_accessor :config

    def render_file(file, blog, options={})
      render(:file, file, blog, options)
    end

    def render_html(string, blog, options={})
      render(:html, string, blog, options)
    end

    private

    def render(setter, theme, blog, options)
      parser = Parser.new
      parser.send("#{setter}=", theme)

      blog = create_blog blog

      options = parser.options.merge(options)

      Renderer::Document.new(parser.tree, blog, options).render
    end

    def create_blog(blog)
      if blog.is_a? Resource::Blog
        blog
      elsif blog.is_a? Hash
        create_blog_from_hash blog
      elsif File.exists? blog
        json = ActiveSupport::JSON.decode(open(blog).read)
        create_blog_from_hash json
      else
        Resource::Blog.new(blog)
      end
    end

    def create_blog_from_hash(hash)
      hash = hash["response"] if hash.key? "response"
      Resource::Blog.new("#{hash["blog"]["name"]}.tumblr.com", hash)
    end

  end

end

if Kernel.const_defined? :Middleman
  require "middleman/extensions/tumblargh"
  Middleman::Extensions.register(:tumblargh, Middleman::Extensions::Tumblargh)
end
