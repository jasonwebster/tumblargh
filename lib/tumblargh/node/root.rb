module Tumblargh
  module Node

    class Root < Base

      def to_tree
        elements.map { |e| e.to_tree  }
      end

    end

  end
end
