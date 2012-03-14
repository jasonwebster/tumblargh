module Tumblargh

  autoload :API,       'tumblargh/api'
  autoload :Parser,    'tumblargh/parser'
  autoload :Node,      'tumblargh/node'
  autoload :Renderer,  'tumblargh/renderer'

  def self.render(template, blog)
    tree = Parser.new.parse_uri(template)
    blog = API::Blog.new(blog)

    Renderer::Document.new(tree, blog).render
  end

end
