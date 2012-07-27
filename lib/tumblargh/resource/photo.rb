module Tumblargh
  module Resource

    class Photo < Base

      def photo_url(size=500)
        size = size.to_i

        original_size
        res = alt_sizes.select do |p|
          p[:width] == size
        end

        res.empty? ? original_size['url'] : res.first[:url]
      end

      def photo_alt
        original_size['url'].match(/\/(\w+).\w{3}$/)[1]
      end

    end

  end
end
