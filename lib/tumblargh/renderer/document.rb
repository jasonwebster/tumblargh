module Tumblargh
  module Renderer
    class Document < Base

      # Are we rendering a permalink page?
      def permalink?
        options[:permalink] == true
      end

      # TAGS ----------
      contextual_tag :title
      contextual_tag :description

      def meta_description
        strip_html(description)
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

      def boolean(key)
        custom_value_for_type :if, key
      end

      def custom_value_for_type(type, key)
        config[type][key] rescue raise "No appearance option for #{type}:#{key}"
      end

      # END TAGS ------

      def render
        node.map do |n|
          Renderer.factory(n, self).render
        end.flatten.join('')
      end
    end
  end
end
