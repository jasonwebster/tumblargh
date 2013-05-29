module Tumblargh
  module Resource
    class Photo < Base

      # @return [String]
      def photo_url(size = 500)
        read_property_for_size(size, :url) || original_size[:url]
      end

      # @return [Fixnum]
      def photo_width(size = 500)
        read_property_for_size(size, :width)
      end

      # @return [Fixnum]
      def photo_height(size = 500)
        read_property_for_size(size, :height)
      end

      private

      def read_property_for_size(size, prop)
        size = find_size(size)
        size && size[prop]
      end

      def find_size(size)
        size = size.to_i
        alt_sizes.detect { |p| p[:width] == size }
      end

    end
  end
end
