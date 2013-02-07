module Tumblargh
  module Renderer
    module Blocks
      # Posts Loop
      #
      # {block:Posts} is executed once for each post. Some post related tags can 
      # exist outside of a `type` block, such as {Title} or {Permalink}, so
      # they should be defined here
      class Posts < Base

        contextual_tag :post_id, :id
        contextual_tag :post_type, :type
        contextual_tag :title
        contextual_tag :tags_as_classes
        contextual_tag :caption

        def permalink
          url = context.post_url
          url.gsub(/^http:\/\/[^\/]+/, '')
        end

        def permalink?
          context.permalink?
        end

        def post_notes_url
          # http://bikiniatoll.tumblr.com/notes/1377511430/vqS0xw8sm
          "/notes/#{context.id}/"
        end

        def reblog_url
          "/reblog/#{context.reblog_key}"
        end

        def render
          if context.is_a? Resource::Post
            super
          else
            posts = permalink? ? [context.posts.first] : context.posts

            posts.map do |post|
              post.context = self
              self.class.new(node, post).render
            end.flatten.join('')
          end
        end

      end
    end
  end
end
