module Tumblargh
  module Renderer
    module Blocks

      class Photoset < Photo
        def should_render?
          context_post.type == 'photoset' && context_post.photos.size > 1
        end

        def photoset
          html = <<-HTML
            <div id="photoset_67521224359" class="html_photoset">    <iframe id="photoset_iframe_#{context_post.id}" class="photoset" scrolling="no" frameborder="0" width="100%" style="border:0px; background-color:transparent; overflow:hidden;" src="http://posttypes.tumblr.com/post/#{context_post.id}/photoset_iframe/posttypes/tumblr_mwjhls1Xr11sm9w1y/0/false"></iframe></div>
          HTML
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
