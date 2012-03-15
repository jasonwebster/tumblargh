module Tumblargh
  module Renderer
    module Blocks
      # TODO: Impl.
      # Rendered if there is a "previous" page (newer posts) to navigate to.
      class PreviousPage < Base
        def previous_page
        end
      end

      # Rendered if there is a "next" page (older posts) to navigate to.
      class NextPage < Base
        def next_page
        end
      end

      # Rendered if there is a "previous" or "next" page.
      class Pagination < Base
      end

      # undocumented??
      class PermalinkPagination < Base
      end

      class PreviousPost < Base
        def previous_post
        end
      end

      class NextPost < Base
        def next_post
        end
      end

      # {block:JumpPagination length="5"} {/block:JumpPagination} 
      # Rendered for each page greater than the current page minus one-half length up to current page plus one-half length.
      class JumpPagination < Base
      end

      # Rendered when jump page is not the current page.
      class JumpPage < Base
        def url
        end

        def page_number
        end
      end

      # Rendered when jump page is the current page.
      class CurrentPage < JumpPage
      end

      # Rendered if Submissions are enabled.
      class SubmissionsEnabled < Base
      end

      # Rendered if Submissions are enabled.
      class AskEnabled < Base
        def should_render?
          true
        end
      end
    end
  end
end
