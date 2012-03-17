module Tumblargh
  module Renderer

    class Base

      class << self

        # Define a simple tag on the block.
        # Name being tag name, and optionally the  attibute/method to call 
        # on the context. If the second argument is left off, it'll just use the tag name.
        def contextual_tag(name, attribute=nil)
          class_eval do 
            define_method name do
              context.send(attribute || name)
            end
          end
        end

      end


      attr_reader :node
      attr_accessor :context

      def initialize(node, context)
        @node = node
        @context = context
      end

      def context_post
        real_post = context
        while not real_post.is_a?(API::Post)
          real_post = real_post.context
        end

        real_post
      end

      def escape_html(str)
        CGI.escapeHTML(str)
      end

      def escape_url(url)
        CGI.escape(url)
      end

      def strip_html(str)
        str.gsub(/<\/?[^>]*>/, '')
      end

      def render
      end

      alias_method :to_s, :render

      def method_missing(method, *arguments)
        # puts "mm #{method} - #{self.class.name} -- context is: #{context.class.name}"
        raise "Can't find anything to do with '#{method}'" if context.nil?
        context.send(method, *arguments)
      end

    end
  end
end
