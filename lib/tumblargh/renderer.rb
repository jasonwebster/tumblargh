require 'cgi'

module Tumblargh
  module Renderer

    autoload :Base,    'tumblargh/renderer/base'
    autoload :Literal, 'tumblargh/renderer/literal'

    autoload :FontTag,     'tumblargh/renderer/tag'
    autoload :TextTag,     'tumblargh/renderer/tag'
    autoload :ImageTag,    'tumblargh/renderer/tag'
    autoload :ColorTag,    'tumblargh/renderer/tag'
    autoload :Tag,         'tumblargh/renderer/tag'

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
        end

        base = "Blocks::#{block_name}"
      end

      klass_name = "Tumblargh::Renderer::#{base}"
      klass = klass_name.constantize

      klass.new(node, context, *args)
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

      # Appearance options 
      # http://www.tumblr.com/docs/en/custom_themes#appearance-options
      def color(key)
        'TODO CUSTOM COLOR'
      end

      def font(key)
        'TODO CUSTOM FONT'
      end

      def image(key)
        'TODO CUSTOM IMAGE'
      end

      def text(key)
        'TODO CUSTOM TEXT'
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

    end
  end
end
