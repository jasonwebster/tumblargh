module Tumblargh
  module Node
    class Block < Root

      def name
        # First node is BlockStart
        elements.first.name
      end

      def options
        elements.first.options
      end

      def to_tree
        ary = [type, name, options]

        # Second node is a Treetop SyntaxNode which holds
        # the rest of the block contents. Extra parse node
        # due to grouping in the block grammar
        elements[1].elements.each do |e|
          if e.respond_to?(:to_tree)
            ary << e.to_tree
          else
            raise ParserError, "Unknown node type '#{e.class.name}' in Block '#{name}'"
          end
        end

        ary
      end

    end
  end
end
