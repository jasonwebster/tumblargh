module Tumblargh
  module Resource

    class Blog < Base
      
      attr_accessor :domain

      def initialize(domain, attrs=nil)
        @domain = domain
        self.attributes = attrs.nil? ? fetch : attrs
      end

      def attributes=(attrs)
        attrs = attrs.with_indifferent_access

        # We passed in result from /posts, or a local file
        if attrs.include?(:posts) && attrs.include?(:blog)
          self.posts = attrs[:posts]
          attrs.delete(:posts)

          self.attributes = attrs[:blog]
        else
          super(attrs)
        end

        @attributes
      end

      def fetch
        API.blog(domain)
      end

      def fetch!
        attributes = fetch
      end

      def posts
        @posts || self.posts = API.posts(domain)
        @posts # Whyyy??? Must I do this?
      end

      def posts=(ary)
        @posts = ary.map { |p| Post.new(p, self) }
      end

    end

  end
end
