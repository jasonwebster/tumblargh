module Tumblargh
  module Node

    class Tag < Base
      def type
        return @type if defined?(@type)

        n = name.split(':')
        if n.size == 2
          @type = "#{n.first.camelize.to_sym}Tag"

          raise "There's an unclosed block somewhere..." if @type == 'BlockTag'

          @type
        else
          super
        end
      end

      def name
        elements[1].text_value
      end

      def to_tree
        return [type, name]
      end

    end

  end
end
