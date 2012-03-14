module Tumblargh
  module API

    class Base
      
      def initialize(attrs={})
        self.attributes = attrs
      end

      attr_reader :attributes

      def attributes=(attrs)
        @attributes = attrs.with_indifferent_access

        # .map do |el|
        #   el = el.with_indifferent_access if el.is_a? Hash
        #   el
        # end
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
        end
      end
    end

  end
end
