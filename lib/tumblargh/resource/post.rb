module Tumblargh
  module Resource

    class Post < Base

      def initialize(attrs, blog)
        @blog = blog
        super(attrs)
      end

      def type
        if @attributes[:type] == 'photo'
          photos.size > 1 ? 'photoset' : 'photo'
        else
          @attributes[:type]
        end
      end

      # Override method_missing so this does not propagate
      def title
        @attributes[:title]
      end

      def date
        @date ||= @attributes[:date].to_time
      end

      # URL of the photo for this post
      #
      # @return [String]
      def photo_url(size = 500)
        photos.present? && photos.first.photo_url(size)
      end

      # @return [Fixnum]
      def photo_width(size = 500)
        photos.present? && photos.first.photo_width(size)
      end

      # @return [Fixnum]
      def photo_height(size = 500)
        photos.present? && photos.first.photo_height(size)
      end

      def video(size = 500)
        return nil if player.blank?

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
        @notes || self.notes = API.notes(@blog.domain, :id => id)
        @notes
      end

      def notes=(ary)
        @notes = ary.map { |n| Note.new(n) }
      end

      def dialogue
        @dialogue ||= (@attributes[:dialogue] || []).map { |t| Dialogue.new(t) }
      end

      def photos
        @photos ||= (@attributes[:photos] || []).map { |p| Photo.new(p) }
      end

    end

  end
end
