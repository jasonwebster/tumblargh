module Tumblargh
  module Renderer
    module Blocks

      class Photos < Base

        def render
          if context.is_a? Resource::Photo
            super
          else
            context.photos.map do |p|
              p.context = self
              self.class.new(node, p).render
            end.flatten.join('')
          end
        end
      
      end

    end
  end
end

