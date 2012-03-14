module Tumblargh
  module Node

    class HtmlStyleTag < Base
      
      def to_tree
        ary = [type]

        # Second node is a Treetop SyntaxNode which holds
        # the rest of the block contents. Extra parse node
        # due to grouping in the block grammar
        elements[2].elements.each do |e|
          if e.respond_to?(:to_tree)
            ary << e.to_tree
          else
            raise "Unknown node type '#{e.class.name}' in "
          end
        end

        return ary
      end

    end

  end
end
