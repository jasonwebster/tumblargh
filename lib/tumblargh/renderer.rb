require 'active_support'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/inflector'
require 'cgi'

module Tumblargh
  module Renderer

    autoload :Base,    'tumblargh/renderer/base'

    def self.factory(node, context)
      base = node.first.to_s

      if base == 'Block'
        block_name = node[1]

        if block_name[0..1] == 'If'
          block_name = 'Boolean'
        end

        base = "Blocks::#{block_name}"
      end

      klass_name = "Tumblargh::Renderer::#{base}"
      klass = klass_name.constantize

      klass.new(node, context)
    end

    # Document scoped tags live here
    class Document < Base
      # TAGS ----------
      def title
        context.title
      end

      def favicon
        # TODO
        ''
      end

      def rss
        "#{context.url}rss"
      end

      # END TAGS ------

      def render
        res = node.map do |n|
          renderer = Renderer.factory(n, self)

          # TODO LOLOLOLOLOLOLOL
          if renderer.class.name == 'Tumblargh::Renderer::Blocks::Posts'
            context.posts.map do |p|
              p.context = self
              post_renderer = renderer.class.new(n, p)
              post_renderer.render
            end
          else
            renderer.render
          end
        end

        res.flatten.join('')
      end
    end

    class Literal < Base
      def render
        node[1]
      end
    end

    class Tag < Base
      def render
        # {PhotoURL-500} becomes photo_url(500)
        tag, *args = node[1].split('-')
        context.send tag.underscore, *args
      end
    end


    module Blocks
      class Base < Renderer::Base

        # def self.render_check=
        # end

        def should_render?
          true
        end

        def render
          return '' unless should_render?

          sig, type, *nodes = node

          res = nodes.map do |n|
            # puts "#{self.class.name} --> #{self.context.class.name}"
            renderer = Renderer.factory(n, self)
            renderer.render
          end

          res.join('')
        end
      end


      class Description < Base
        def should_render?
          !description.blank?
        end

        def description
          context.description
        end

        def metadescription
          escape(description)
        end

      end



      class PreviousPage < Base
      end

      class NextPage < Base
      end

      # Posts Loop
      #
      # {block:Posts} is executed once for each post. Some post related tags can 
      # exist outside of a `type` block, such as {Title} or {Permalink}, so
      # they should be defined here
      class Posts < Base

        def permalink
          context.post_url
        end

        def title
          context.title
        end

        def caption
          context.caption
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

      # Meta-block for Appearance booleans, like {block:IfSomething}
      class Boolean < Base
        def should_render?
          context
        end
      end

    end
  end
end
