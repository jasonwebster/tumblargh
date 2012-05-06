module Tumblargh
  module Renderer
    module Blocks
      # Rendered for each of a post's tags.
      # TODO: Render for each tag in a post
      class Tags < Base
        def tag
          context.name
        end

        def url_safe_tag
          escape_url(tag)
        end

        def tag_url
          "/tagged/#{url_safe}"
        end

        def tag_url_chrono
          "#{tag_url}/chrono"
        end

        def render
          if context.is_a? Resource::Tag
            super
          else
            context.tags.map do |tag|
              tag.context = self
              self.class.new(node, tag).render
            end.flatten.join('')
          end
        end

      end
    end
  end
end
