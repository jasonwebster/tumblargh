module Tumblargh
  module Renderer
    module Blocks

      class Lines < Base

        contextual_tag :label
        contextual_tag :name
        contextual_tag :line, :phrase

        # "odd" or "even" for each line of this post.
        # TODO Implementation
        def alt
        end


        # A unique identifying integer representing the user of the current line of this post.
        # TODO Implementation
        def user_number
        end

        def render
          if context.is_a? Resource::Dialogue
            super
          else
            context.dialogue.map do |l|
              l.context = self
              self.class.new(node, l).render
            end.flatten.join('')
          end
        end

      end

      class Label < Base

        should_render_unless_blank :label

      end

    end
  end
end

