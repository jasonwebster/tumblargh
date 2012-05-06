module Tumblargh
  module Resource

    class Base

      # Needed by renderer for context propagation
      attr_accessor :context
      
      def initialize(attrs={})
        self.attributes = attrs
      end

      attr_reader :attributes

      def attributes=(attrs)
        @attributes = attrs.with_indifferent_access
      end

      def method_missing(method_symbol, *arguments)
        method_name = method_symbol.to_s

        if method_name =~ /(=|\?)$/
          case $1
          when "="
            attributes[$`] = arguments.first
          when "?"
            attributes[$`]
          end
        else
          return attributes[method_name] if attributes.include?(method_name)

          # propagating renderer context
          return context.send(method_symbol, *arguments) unless context.nil?
        end
      end
    end

  end
end
