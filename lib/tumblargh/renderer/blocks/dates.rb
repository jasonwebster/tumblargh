module Tumblargh
  module Renderer
    module Blocks

      # Rendered for all posts.
      # Always wrap dates in this block so they will be properly hidden on non-post pages.
      class Date < Base
      end

      # Rendered for posts that are the first to be listed for a given day.
      class NewDayDate < Base
      end

      # Rendered for subsequent posts listed for a given day.
      class SameDayDate < Base
      end
      
    end
  end
end

