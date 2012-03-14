module Tumblargh
  module Node

    class BlockStart < Base

      def name
        str = elements[1].text_value
        "#{str[0].upcase}#{str[1..str.size]}"
      end

      def matching_end
        "{/block:#{name}}"
      end

      def to_tree
        return [type, name]
      end

    end

  end
end
