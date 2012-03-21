module Tumblargh
  module API

    class Blog < Base
      
      def initialize(url)
        @url = url
        fetch
      end

      def domain
        @url
      end

      def fetch
        self.attributes = API.fetch("#{@url}/info")['blog']
      end

      def parse(resp)
        resp['blog']
      end

      def posts
        return @posts if defined?(@posts)
        @posts = API.fetch("#{@url}/posts")['posts'].map do |p|
          Post.new(p, self)
        end
      end

    end

  end
end
