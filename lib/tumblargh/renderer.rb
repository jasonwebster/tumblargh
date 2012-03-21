require 'cgi'

require 'tumblargh/renderer/base'
require 'tumblargh/renderer/document'
require 'tumblargh/renderer/literal'
require 'tumblargh/renderer/tag'

module Tumblargh
  module Renderer

    def self.factory(node, context)
      args = []
      base = node.first.to_s

      if base == 'Block'
        block_name = node[1]

        if block_name[0..1] == 'If'
          if block_name[2..4] ==  'Not'
            args << block_name[5..block_name.size]
            block_name = 'InverseBoolean'
          else
            args << block_name[2..block_name.size]
            block_name = 'Boolean'
          end
        elsif n_post = block_name.match(/Post(\d+)/)
          block_name = 'NumberedPost'
          args << n_post[1].to_i
        end

        base = "Blocks::#{block_name}"
      end

      klass_name = "Tumblargh::Renderer::#{base}"
      klass = klass_name.constantize

      klass.new(node, context, *args)
    end


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

      # Posts Loop
      #
      # {block:Posts} is executed once for each post. Some post related tags can 
      # exist outside of a `type` block, such as {Title} or {Permalink}, so
      # they should be defined here
      class Posts < Base

        contextual_tag :post_id, :id
        contextual_tag :post_type, :type
        contextual_tag :title
        contextual_tag :caption

        def permalink
          url = context.post_url
          
          url.gsub(/^http:\/\/[^\/]+/, '')
        end

        def render
          sig, type, *nodes = node

          res = nodes.map do |n|
            renderer = Renderer.factory(n, self)

            # TODO LOLOLOLOLOLOLOL
            if renderer.class.name == 'Tumblargh::Renderer::Blocks::Tags'
              context.posts.tags.map do |t|
                t.context = self
                post_renderer = renderer.class.new(n, t)
                post_renderer.render
              end
            else
              renderer.render
            end
          end

          res.flatten.join('')
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
          # TODO Looks like photosets come as type = 'photo'
          self.class.name.split('::').last.downcase == context.type
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
        def photo_url(size=500)
          context.photo_url(size)
        end

        def photo_alt
          strip_html(context.caption)
        end
      end

      class Photoset < Photo
      end

      class Video < Photo
      end

      class Audio < Post
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

      class Answer < Post
        def question
        end

        def answer
        end

        def asker
        end

        def asker_portrait_url(size)
        end
      end

      # Meta-block for Appearance booleans, like {block:IfSomething}
      class Boolean < Base
        attr_reader :variable

        def initialize(node, context, *args)
          @variable = args[0]
          super(node, context)
        end

        def should_render?
          context.send(variable.underscore)
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
      end


      # Rendered on index (post) pages.
      class IndexPage < Base
        def should_render?
          ! permalink?
        end
      end

      # Rendered on post permalink pages.
      class PermalinkPage < Base
        def should_render?
          permalink?
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

      require 'tumblargh/renderer/blocks/dates'
      require 'tumblargh/renderer/blocks/notes'
      require 'tumblargh/renderer/blocks/reblogs'
      require 'tumblargh/renderer/blocks/navigation'



    end
  end
end
