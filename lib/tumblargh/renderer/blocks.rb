module Tumblargh
  module Renderer
    module Blocks

      require 'tumblargh/renderer/blocks/base'

      class Description < Base
        def should_render?
          !description.blank?
        end
      end

      class NumberedPost < Base
        attr_reader :num

        def initialize(node, context, *args)
          @num = args[0]
          super(node, context)
        end

        def should_render?
          num == context.posts.index(context_post) + 1
        end
      end

      # Common post blocks
      class Title < Base
        def should_render?
          !(title.nil? || title.blank?)
        end
      end

      class Caption < Base
        def should_render?
          !(caption.nil? || caption.blank?)
        end
      end

      # Base post type
      class Post < Base
        def should_render?
          self.class.name.demodulize.downcase == context.type
        end
      end

      # Source block for Quote posts
      class Source < Base
        def should_render?
          !source.blank?
        end

        def source
          context.source
        end
      end

      class Text < Post
      end

      class Photo < Post
        def should_render?
          context_post.type == 'photo' && context_post.photos.size == 1
        end

        def photo_alt
          strip_html(context.caption)
        end
      end



      class Video < Photo
      end



      class Quote < Post
        def quote
          context.text
        end
      end

      class Chat < Post
      end

      class Link < Post
      end


      # Meta-block for Appearance booleans, like {block:IfSomething}
      class Boolean < Base
        attr_reader :variable

        def initialize(node, context, options = {}, *args)
          @variable = args[0]
          super(node, context, options)
        end

        def should_render?
          context.boolean(variable.downcase)
        end
      end

      class InverseBoolean < Boolean
        def should_render?
          ! super
        end
      end


      # Rendered on permalink pages. (Useful for displaying the current post's
      # title in the page title)
      class PostTitle < Base
        def should_render?
          false
        end

        def post_title
          # TODO: Implementation
        end
      end

      # Identical to {PostTitle}, but will automatically generate a summary
      # if a title doesn't exist.
      class PostSummary < PostTitle
        def post_summary
          # TODO: Implementation
        end
      end



      class ContentSource < Base
        def should_render?
          !source_title.nil?
        end

        contextual_tag :source_url
        contextual_tag :source_title

        # TODO: Impl.
        def black_logo_url
        end

        def logo_width
        end

        def logo_height
        end

      end

      class SourceLogo < Base
        # TODO: Impl.
      end

      class NoSourceLogo < SourceLogo
        def should_render?
          ! super
        end
      end

      class HasTags < Base
        def should_render?
          !(tags.nil? || tags.blank?)
        end
      end


      # Rendered on index (post) pages.
      class IndexPage < Base
        def should_render?
          ! context.permalink?
        end
      end

      # Rendered on post permalink pages.
      class PermalinkPage < Base
        def should_render?
          context.permalink?
        end
      end

      class SearchPage < Base
        def should_render?
          false
        end
      end

      class NoSearchResults < Base
        def should_render?
          false
        end
      end

      class TagPage < Base
        def should_render?
          false
        end
      end

      # Rendered if you have defined any custom pages.
      class HasPages < Base
        # TODO: Implementation

        def should_render?
          false
        end
      end

      # Rendered for each custom page.
      class Pages < Base
        # TODO: Implementation

        def should_render?
          false
        end

        # custom page url
        def url
        end

        # custom page name/label
        def label
        end

      end

      # Rendered if you have Twitter integration enabled.
      class Twitter < Base
        # TODO: Implementation

        def should_render?
          false
        end

        def twitter_username
        end

      end


      # {block:Likes} {/block:Likes}  Rendered if you are sharing your likes.
      # {Likes} Standard HTML output of your likes.
      # {Likes limit="5"} Standard HTML output of your last 5 likes.
      # Maximum: 10
      # {Likes width="200"} Standard HTML output of your likes with Audio and Video players scaled to 200-pixels wide.
      # Scale images with CSS max-width or similar.
      # {Likes summarize="100"} Standard HTML output of your likes with text summarize to 100-characters.
      # Maximum: 250
      class Likes < Base
        # TODO: Implementation

        def should_render?
          false
        end

        def likes
        end

      end

      require 'tumblargh/renderer/blocks/answer'
      require 'tumblargh/renderer/blocks/audio'
      require 'tumblargh/renderer/blocks/chat'
      require 'tumblargh/renderer/blocks/dates'
      require 'tumblargh/renderer/blocks/navigation'
      require 'tumblargh/renderer/blocks/notes'
      require 'tumblargh/renderer/blocks/photoset'
      require 'tumblargh/renderer/blocks/posts'
      require 'tumblargh/renderer/blocks/reblogs'
      require 'tumblargh/renderer/blocks/tags'

    end
  end
end
