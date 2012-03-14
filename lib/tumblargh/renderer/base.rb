module Tumblargh
  module Renderer

    class Base

      attr_reader :node
      attr_accessor :context

      def initialize(node, context)
        @node = node
        @context = context
      end

      def escape(str)
        CGI.escapeHTML(str)
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
