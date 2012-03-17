module Tumblargh
  module API

    class Blog < Base
      
      def initialize(url)
        @url = url
        fetch
      end

      def fetch
        self.attributes = API.fetch("#{@url}/info")['blog']
      end

      def parse(resp)
        resp['blog']
      end

      # Override method_missing so this does not propagate
      def title
        @attributes[:title]
      end

      def posts
        return @posts if defined?(@posts)
        @posts = API.fetch("#{@url}/posts")['posts'].map do |p|
          Post.new p
        end
      end

    end

  end
end
