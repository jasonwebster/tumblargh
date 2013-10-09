require 'cgi'

require 'tumblargh/renderer/base'
require 'tumblargh/renderer/blocks'
require 'tumblargh/renderer/document'
require 'tumblargh/renderer/literal'
require 'tumblargh/renderer/tag'

module Tumblargh
  module Renderer

    def self.factory(node, context, options = {})
      args = []
      base = node.first.to_s

      if base == 'Block'
        block_name = node[1]

        if block_name[0..1] == 'If'
          if block_name[2..4] ==  'Not'
            args << block_name[5..block_name.size]
            block_name = 'InverseBoolean'
          else
            args << block_name[2..block_name.size]
            block_name = 'Boolean'
          end
        elsif n_post = block_name.match(/Post(\d+)/)
          block_name = 'NumberedPost'
          args << n_post[1].to_i
        end

        base = "Blocks::#{block_name}"
      end

      klass_name = "Tumblargh::Renderer::#{base}"
      klass = klass_name.constantize

      klass.new(node, context, options, *args)
    end

  end
end
