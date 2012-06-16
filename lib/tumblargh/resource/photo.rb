module Tumblargh
  module Resource

    class Photo < Base

      def photo_url(size=500)
        size = size.to_i

        res = alt_sizes.select do |p|
          p[:width] == size
        end

        res.empty? ? original_size[:url] : res.first[:url]
      end

    end

  end
end
