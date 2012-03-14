module Tumblargh
  module Renderer
    class Tag < Base
      def render
        # {PhotoURL-500} becomes photo_url(500)
        tag, *args = node[1].split('-')
        context.send tag.underscore, *args
      end
    end

    class CustomTag < Tag
      def method_name
        self.class.name.demodulize.sub('Tag', '').downcase
      end

      def render
        context.send(method_name, node[1].split(':').last)
      end
    end

    class ColorTag < CustomTag
    end

    class ImageTag < CustomTag
    end

    class FontTag < CustomTag
    end

  end
end
