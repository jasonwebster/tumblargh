module Tumblargh
  module API

    class Post < Base
      def initialize(attrs, blog)
        @blog = blog
        super(attrs)
      end

      # Override method_missing so this does not propagate
      def title
        @attributes[:title]
      end

      def date
        @date ||= @attributes[:date].to_time
      end

      def photo_url(size=500)
        return nil if (photos.nil? || photos.empty?)

        size = size.to_i

        orig = photos.first[:original_size]
        res = photos.first[:alt_sizes].select do |p|
          p[:width] == size
        end

        res.empty? ? orig[:url] : res.first[:url]
      end

      def video(size=500)
        return nil if (player.nil? || player.empty?)

        size = size.to_i

        res = player.select do |p|
          p[:width] == size
        end

        res.empty? ? nil : res.first[:embed_code]
      end

      def tags
        @tags ||= @attributes[:tags].map do |t|
          Tag.new({ :name => t })
        end
      end

      def notes
        return @notes if defined?(@notes)

        path = "#{@blog.domain}/posts"
        query = { :id => id, :notes_info => 'true' }
        @notes = API.fetch(path, query)['posts'][0]['notes'].map do |n|
          Note.new(n)
        end
      end

      def dialogue
        @dialogue ||= @attributes[:dialogue].map do |t|
          Base.new(t)
        end
      end

    end

  end
end
