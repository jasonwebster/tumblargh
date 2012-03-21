module Tumblargh
  module Renderer
    module Blocks

      # Rendered on permalink pages if this post has notes.
      class PostNotes < Base
        def should_render?
          context.permalink? && note_count > 0
        end

        def note_count
          context_post.note_count || 0
        end

        def post_notes
          buf = ['<ol class="notes">']

          # TODO: Support notes with_commentary
          buf << context_post.notes.map do |note|
            classes = "note without_commentary #{note.type}"
            action = case note.type
            when 'like'
              'liked this'
            when 'reblog'
              'reblogged this from somewhere?'
            end

            <<-eos
            <li class='#{classes}'>
              <a href="#{note.blog_url}" title="" rel="nofollow">
                <img src="http://assets.tumblr.com/images/default_avatar_16.gif" class="avatar" alt="">
              </a>
              
              <span class="action">
                <a href="#{note.blog_url}" title="" rel="nofollow">#{note.blog_name}</a> 
                #{action}
              </span>

              <div class="clear"></div>
            </li>
            eos
          end.join("\n")

          buf << '</ol>'

          buf.join ''
        end
      end

      # Rendered if this post has notes.
      # Always wrap note counts in this block so they will be properly hidden on non-post pages.
      class NoteCount < Base
        def should_render?
          note_count > 0
        end

        def note_count
          context_post.note_count || 0
        end

        def note_count_with_label
          count = note_count
          "#{ count } note#{ count == 1 ? '' : 's' }"
        end
      end
    end
  end
end
