module Tumblargh
  module Node
    class BlockStart < Base

      def name
        str = elements[1].text_value
        "#{str[0].upcase}#{str[1..str.size]}"
      end

      def options
        arguments = elements[3]
        return {} if arguments.nil? || arguments.elements.nil?

        arguments.elements.inject({}) do |memo, node|
          nodes = node.elements.first.elements
          k = nodes[0].text_value
          v = nodes[3].text_value

          memo[k] = v
          memo
        end
      end

      def matching_end
        "{/block:#{name}}"
      end

      def to_tree
        return [type, name, options]
      end

    end
  end
end
