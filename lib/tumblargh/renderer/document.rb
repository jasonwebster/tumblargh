 module Tumblargh
  module Renderer

    class Document < Base

      attr_accessor :config

      def initialize(node, context, config)
        @config = config
        super(node, context)
      end

      # Are we rendering a permalink page?
      def permalink?
        @config[:permalink] == true
      end

      # TAGS ----------
      contextual_tag :title
      contextual_tag :description

      def meta_description
        strip_html(description)
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
        custom_value_for_type :color, key
      end

      def font(key)
        custom_value_for_type :font, key
      end

      def image(key)
        custom_value_for_type :image, key
      end

      def text(key)
        custom_value_for_type :text, key
      end

      def custom_value_for_type(type, key)
        config[type][key] rescue raise "No appearance option for #{type}:#{key}"
      end

      # END TAGS ------

      def render
        res = node.map do |n|
          renderer = Renderer.factory(n, self)

          # TODO LOLOLOLOLOLOLOL
          if renderer.class.name == 'Tumblargh::Renderer::Blocks::Posts'
            posts = permalink? ? [context.posts.first] : context.posts

            posts.map do |p|
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
  end
end
