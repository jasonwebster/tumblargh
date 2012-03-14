module Tumblargh
  module Renderer

    class Base

      attr_reader :node
      attr_reader :context

      def initialize(node, context)
        @node = node
        @context = context
      end

      def resolve_renderer(node)
        base = node.first.to_s

        base = "Blocks::#{node[1]}" if base == 'Block'

        klass_name = "Tumblargh::Renderer::#{base}"
        klass_name.constantize rescue raise "Undefined block #{klass_name}"
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
