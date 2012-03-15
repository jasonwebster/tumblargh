module Tumblargh
  module Renderer
    module Blocks

      class PostNotes < Base
        def should_render?
          false
        end
      end

      class NoteCount < Base
      end

    end
  end
end
