module Tumblargh
  module Renderer
    module Blocks

      class Photoset < Photo
        def should_render?
          context_post.type == 'photoset' && context_post.photos.size > 1
        end
      end

      # Rendered for each of the Photoset photos
      class Photos < Base
        def render
          if context.is_a? Resource::Photo
            super
          else
            context.photos.map do |photo|
              photo.context = self
              self.class.new(node, photo).render
            end.flatten.join('')
          end
        end
      end

    end
  end
end
