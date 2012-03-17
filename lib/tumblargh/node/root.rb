module Tumblargh
  module Node

    class Root < Base

      def to_tree
        elements.map(&:to_tree)
      end

      def to_s
        elements.map(&:to_s).join ''
      end

    end

  end
end
