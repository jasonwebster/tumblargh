module Tumblargh
  module Resource

    class Blog < Base
      
      attr_accessor :domain

      def initialize(domain, attrs=nil)
        @domain = domain

        attributes = attrs ? attrs : fetch
      end

      def attributes=(attrs)
        attrs = super(attrs)

        if attrs.include?(:posts)
          posts = attrs[:posts]
          @attributes.delete(:posts)
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
