module Tumblargh
  module Renderer
    module Blocks
      class Base < Renderer::Base

        class << self
          attr_accessor :should_render_if
          alias_method :should_render_unless_blank, :should_render_if=
          alias_method :should_render_unless_empty, :should_render_if=
        end


        def should_render?
          if defined?(@should_render_if)
            val = send(@should_render_if)
            return !(val || val.nil? || (val.respond_to?(:blank?) ? val.blank? : val.empty?))
          end

          true
        end

        def render
          return '' unless should_render?

          sig, type, *nodes = node

          res = nodes.map do |n|
            Renderer.factory(n, self).render
          end

          " #{res.join('')} "
        end
      end
    end
  end
end
