module Tumblargh
  module Node

    class Tag < Base
      
      def name
        elements[1].text_value
      end

      def to_tree
        return [type, name]
      end

    end

  end
end
