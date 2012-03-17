module Tumblargh
  module Node

    class Base < Treetop::Runtime::SyntaxNode

      def type
        @type ||= self.class.name.split('::').last.to_sym
      end

      def to_tree
        [type, text_value]
      end

      def to_s
        text_value
      end

    end

  end
end
