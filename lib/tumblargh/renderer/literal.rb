module Tumblargh
  module Renderer
    class Literal < Base
      def render
        node[1]
      end
    end
  end
end
