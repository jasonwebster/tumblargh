module Tumblargh
  module Renderer
    module Blocks
      # TODO: Impl.

      # Rendered if a post was reblogged from another post.
      class RebloggedFrom < Base
        def should_render?
          false
        end

        def reblog_parent_name

        end

        def reblog_parent_title

        end

        def reblog_parent_url
          
        end

        def reblog_parent_portrait_url(size)
        end

        def reblog_root_name
          
        end

        def reblog_root_title
          
        end

        def reblog_root_portrait_url(size)

        end

      end

      class NotReblog < Base
        def should_render?
          true
        end
      end
      
    end
  end
end

