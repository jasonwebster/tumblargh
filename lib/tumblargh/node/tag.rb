module Tumblargh
  module Node

    class Tag < Base
      def type
        return @type if defined?(@type)

        n = name.split(':')
        if n.size == 2
          @type = "#{String.new(n.first).camelize.to_sym}Tag"

          if @type == 'BlockTag'
            raise ParserError, "There's an unclosed block somewhere near `#{name}`"
          end

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
