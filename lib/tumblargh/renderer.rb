require 'active_support'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/inflector'
require 'cgi'

module Tumblargh
  module Renderer

    autoload :Base,    'tumblargh/renderer/base'

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
          klass = resolve_renderer(n)
          if klass
            # TODO LOLOLOLOLOLOLOL
            if klass.name == 'Tumblargh::Renderer::Blocks::Posts'
              context.posts.map do |p|
                renderer = klass.new(n, p)
                renderer.render
              end
            else
              renderer = klass.new(n, self)
              renderer.render
            end
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
            klass = resolve_renderer(n)
            if klass
              # puts "#{self.class.name} --> #{self.context.class.name}"
              renderer = klass.new(n, self)
              renderer.render
            end
          end

          res.join('')
        end
      end


      class Description < Base
        def should_render?
          !context.description.blank?
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

        def initialize(node, context)
          super
        end

        def permalink
          context.post_url
        end

        def title
          context.title
        end

        def caption
          context.caption
        end

        def render
          return '' unless should_render?

          sig, type, *nodes = node

          res = nodes.map do |n|
            klass = resolve_renderer(n)
            if klass
              renderer = klass.new(n, self)
              renderer.render
            end
          end

          res.join('')
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



    end
  end
end
