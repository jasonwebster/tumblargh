module Tumblargh
  module Node

    class BlockStart < Base

      def name
        elements[1].text_value
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
