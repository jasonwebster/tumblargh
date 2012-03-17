module Tumblargh
  module Renderer
    module Blocks
      class Base < Renderer::Base

        def should_render?
          true
        end

        def render
          return '' unless should_render?

          sig, type, *nodes = node

          res = nodes.map do |n|
            # puts "#{self.class.name} --> #{self.context.class.name}"
            renderer = Renderer.factory(n, self)
            renderer.render
          end

          " #{res.join('')} "
        end
      end
    end
  end
end
