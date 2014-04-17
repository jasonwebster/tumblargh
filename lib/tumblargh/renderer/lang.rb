module Tumblargh
  module Renderer
    module Lang

      # http://www.tumblr.com/docs/en/localizing_themes
      # $('#theme_strings tr').each(function() {
      #   var $el = $(this);
      #   var method = $el.find('th').html().replace(/{lang:/, ).replace(/}/, ).toLowerCase().replace(/ /g, "_");
      #   var text   = $el.find('td').text().replace(/\s+/g, " ").replace(/"/g, "'");
      #   console.log("def", method);
      #   console.log("  \ + text + "\);
      #   console.log("end");
      #   console.log();
      # });

      class << self
        def methodize(string = "")
          string.downcase.gsub(" ", "_")
        end

        def from_string(string = "")
          puts "METHOD #{self.methodize(string).to_sym}"
          self.send(self.methodize(string).to_sym)
        rescue NoMethodError
          nil
        end
        def about
          "About"
        end

        def about_me
          "About me"
        end

        def all_of_tumblr
          "All of Tumblr"
        end

        def answer
          "Answer"
        end

        def archive
          "Archive"
        end

        def asked_by_asker
          "Asked by "
        end

        def asked_by_asker_2
          "Asked by <a href=' '> </a>"
        end

        def asker_asked
          " asked"
        end

        def asker_asked_2
          "<a href=' '> </a> asked"
        end

        def audio
          "Audio"
        end

        def audio_post
          "Audio post"
        end

        def authors
          "Authors"
        end

        def back
          "Back"
        end

        def blog_comments_powered_by_disqus
          "Blog comments powered by Disqus"
        end

        def blog_comments_powered_by_disqus_2
          "<a href='http://disqus.com' class='dsq-brlink'>Blog comments powered by <span class='logo-disqus'>Disqus</span></a>"
        end

        def browse_the_archive
          "Browse the Archive"
        end

        def by_postauthorname
          "By "
        end

        def by_postauthorname_2
          "By <a href=' '> </a>"
        end

        def chat
          "Chat"
        end

        def chat_post
          "Chat post"
        end

        def click_for_high_res_photo
          "View high resolution"
        end

        def close
          "Close"
        end

        def comment
          "Comment"
        end

        def continue_reading
          "Continue reading"
        end

        def contributors
          "Contributors"
        end

        def currentpage_of_totalpages
          " of "
        end

        def currentpage_of_totalpages_2
          " <em>of</em> "
        end

        def download
          "Download"
        end

        def download_this_track
          "Download this track"
        end

        def earlier_posts
          "Earlier posts"
        end

        def feed
          "Feed"
        end

        def filed_under
          "Filed under"
        end

        def follow_me
          "Follow me"
        end

        def follow_on_tumblr
          "Follow on Tumblr"
        end

        def follow_on_twitter
          "Follow on Twitter"
        end

        def following
          "Following"
        end

        def found_searchresultcount_results_for_searchquery
          "Found results for "
        end

        def found_searchresultcount_results_for_searchquery_2
          "Found results for <span class='search_query'> </span>"
        end

        def future
          "Future"
        end

        def get_the_rss
          "Get the RSS"
        end

        def group_members
          "Group members"
        end

        def high_res
          "High-res"
        end

        def high_res_photo
          "High-res photo"
        end

        def home
          "Home"
        end

        def install_this_theme
          "Install this theme"
        end

        def it_has_notecount_notes
          "It has notes"
        end

        def it_has_notecount_notes_and_0_comments
          "It has notes and <a href=' #disqus_thread' class='comments_link'>0 comments</a>"
        end

        def later_posts
          "Later posts"
        end

        def latest_tweets
          "Latest Tweets"
        end

        def liked_posts
          "Liked posts"
        end

        def liked_posts_on_tumblr
          "Liked posts on Tumblr"
        end

        def liked_posts_on_tumblr_2
          "Liked posts on <a href='http://www.tumblr.com/'>Tumblr</a>"
        end

        def likes
          "Likes"
        end

        def link
          "Link"
        end

        def link_post
          "Link post"
        end

        def load_more_posts
          "Load more posts"
        end

        def loading
          "Loading"
        end

        def members
          "Members"
        end

        def mobile
          "Mobile"
        end

        def mobile_version
          "Mobile version"
        end

        def more
          "More"
        end

        def more_liked_posts
          "More liked posts"
        end

        def my_blog
          "My blog"
        end

        def navigate
          "Navigate"
        end

        def new
          "New"
        end

        def newer
          "Newer"
        end

        def newer_entries
          "Newer entries"
        end

        def newer_posts
          "Newer posts"
        end

        def next
          "Next"
        end

        def next_day
          "Next day"
        end

        def next_page
          "Next page"
        end

        def next_post
          "Next post"
        end

        def no_more_posts
          "No more posts"
        end

        def no_posts_containing_searchquery
          "No posts containing "
        end

        def no_posts_containing_searchquery_2
          "No posts containing <span class='search_query'> </span>"
        end

        def no_posts_found
          "No posts found"
        end

        def no_results_for_searchquery
          "No results for: "
        end

        def no_results_for_searchquery_2
          "No results for <span class='search_query'> </span>"
        end

        def no_results_found
          "No results found"
        end

        def no_search_results_for_searchquery
          "No search results for: "
        end

        def no_search_results_for_searchquery_2
          "No search results for <span class='search_query'> </span>"
        end

        def notes
          "Notes"
        end

        def old
          "Old"
        end

        def older
          "Older"
        end

        def older_entries
          "Older entries"
        end

        def older_posts
          "Older posts"
        end

        def originally_from_reblogrootname
          "Originally from "
        end

        def originally_from_reblogrootname_2
          "Originally from <a href=' '> </a>"
        end

        def originally_from_reblogroottitle
          "Originally from "
        end

        def originally_from_reblogroottitle_2
          "Originally from <a href=' '> </a>"
        end

        def page_currentpage_of_totalpages
          "Page of "
        end

        def page_currentpage_of_totalpages_2
          "Page <em>of</em> "
        end

        def pages
          "Pages"
        end

        def past
          "Past"
        end

        def people_i_follow
          "People I follow"
        end

        def permalink
          "Permalink"
        end

        def permalink_for_this_post
          "Permalink for this post"
        end

        def photo
          "Photo"
        end

        def photo_post
          "Photo post"
        end

        def photos
          "Photos"
        end

        def photoset
          "Photoset"
        end

        def photoset_post
          "Photoset post"
        end

        def played_playcount_times
          "Played times"
        end

        def plays
          "Plays"
        end

        def posttypenoun_reblogged_from_reblogparentname
          " reblogged from "
        end

        def posttypenoun_reblogged_from_reblogparentname_2
          "<a href=' '> </a> reblogged from <a href=' '> </a>"
        end

        def posttypenoun_reblogged_from_reblogparentname_with_notecount_notes
          " reblogged from with notes"
        end

        def posttypenoun_reblogged_from_reblogparentname_with_notecount_notes_2
          "<a href=' '> </a> reblogged from <a href=' '> </a> with notes"
        end

        def posttypenoun_reblogged_from_reblogparenttitle
          " reblogged from "
        end

        def posttypenoun_reblogged_from_reblogparenttitle_2
          " reblogged from <a href=' '> </a>"
        end

        def posttypenoun_reblogged_from_reblogparenttitle_with_notecount_notes
          " reblogged from with notes"
        end

        def posttypenoun_reblogged_from_reblogparenttitle_with_notecount_notes_2
          " reblogged from <a href=' '> </a> with notes"
        end

        def posttypenoun_reblogged_from_reblogrootname
          " reblogged from "
        end

        def posttypenoun_reblogged_from_reblogrootname_2
          " reblogged from <a href=' '> </a>"
        end

        def posttypenoun_reblogged_from_reblogrootname_with_notecount_notes
          " reblogged from with notes"
        end

        def posttypenoun_reblogged_from_reblogrootname_with_notecount_notes_2
          " reblogged from <a href=' '> </a> with notes"
        end

        def posttypenoun_reblogged_from_reblogroottitle
          " reblogged from "
        end

        def posttypenoun_reblogged_from_reblogroottitle_2
          " reblogged from <a href=' '> </a>"
        end

        def posttypenoun_reblogged_from_reblogroottitle_with_notecount_notes
          " reblogged from with notes"
        end

        def posttypenoun_reblogged_from_reblogroottitle_with_notecount_notes_2
          " reblogged from <a href=' '> </a> with notes"
        end

        def posttypenoun_with_notecount_notes
          " with notes"
        end

        def posttypenoun_with_notecount_notes_2
          "<a href=' '> </a> with notes"
        end

        def posted_timeago
          "Posted "
        end

        def posted_timeago_by_postauthorname
          "Posted by "
        end

        def posted_timeago_by_postauthorname_2
          "Posted by <a href=' '> </a>"
        end

        def posted_timeago_from_source
          "Posted from "
        end

        def posted_timeago_with_notecount_notes
          "Posted with notes"
        end

        def posted_timeago_with_notecount_notes_and_playcount_plays
          "Posted with notes and plays"
        end

        def posted_at_formattedtime
          "Posted at "
        end

        def posted_at_formattedtime_2
          "Posted at <span class='date_string'> </span>"
        end

        def posted_at_formattedtime_3
          "Posted at <a href=' ' class='date_string'> </a>"
        end

        def posted_by_postauthorname
          "Posted by "
        end

        def posted_by_postauthorname_2
          "Posted by <a href=' '> </a>"
        end

        def posted_on_dayofmonth_month_year
          "Posted on , "
        end

        def posted_on_dayofweek_dayofmonth_month_year
          "Posted on , "
        end

        def posted_on_dayofweek_dayofmonth_month_year_2
          "Posted on <span class='date_string'> , </span>"
        end

        def posted_on_dayofweek_dayofmonth_month_year_3
          "Posted on <a href='/day/ / / ' class='date_string'> , </span>"
        end

        def posted_on_dayofweek_month_dayofmonth_year
          "Posted on , "
        end

        def posted_on_dayofweek_month_dayofmonth_year_2
          "Posted on <span class='date_string'> , </span>"
        end

        def posted_on_dayofweek_month_dayofmonth_year_3
          "Posted on <a href='/day/ / / ' class='date_string'> , </span>"
        end

        def posted_on_dayofweek_month_dayofmonthwithsuffix
          "Posted on "
        end

        def posted_on_dayofweek_month_dayofmonthwithsuffix_2
          "Posted on <span class='date_string'> </span>"
        end

        def posted_on_dayofweek_month_dayofmonthwithsuffix_3
          "Posted on <a href='/day/ / / ' class='date_string'> </a>"
        end

        def posted_on_dayofweek_month_dayofmonthwithsuffix_year
          "Posted on <a href='/day/ / / ' class='date_string'> , , </a>"
        end

        def posted_on_dayofweek_the_dayofmonthwithsuffix_of_month_year_at_formattedtime
          "Posted on the of at "
        end

        def posted_on_month_dayofmonth_year
          "Posted on , "
        end

        def posted_on_month_dayofmonth_year_with_notecount_notes
          "Posted on , with notes"
        end

        def posted_on_month_dayofmonth_year_with_notecount_notes_2
          "Posted on <a href=' '> , </a> with notes"
        end

        def posts_tagged_tag
          "Posts tagged "
        end

        def posts_tagged_tag_2
          "Posts tagged <span class='tag'> </span>"
        end

        def posts_tagged_tag_3
          "Posts tagged <a href='/tagged/ '> </a>"
        end

        def powered_by_tumblr
          "Powered by Tumblr"
        end

        def powered_by_tumblr_2
          "Powered by <a href='http://www.tumblr.com/'>Tumblr</a>"
        end

        def prev
          "Prev"
        end

        def prev_post
          "Prev post"
        end

        def previous
          "Previous"
        end

        def previous_day
          "Previous day"
        end

        def previous_page
          "Previous page"
        end

        def previous_post
          "Previous post"
        end

        def quote
          "Quote"
        end

        def quote_post
          "Quote post"
        end

        def rss
          "RSS"
        end

        def rss_feed
          "RSS feed"
        end

        def random
          "Random"
        end

        def random_post
          "Random post"
        end

        def read_more
          "Read more"
        end

        def reblogged
          "Reblogged"
        end

        def reblogged_timeago_from_reblogparentname
          "Reblogged from "
        end

        def reblogged_timeago_from_reblogparentname_2
          "Reblogged from <a href=' '> </a>"
        end

        def reblogged_timeago_from_reblogparenttitle
          "Reblogged from "
        end

        def reblogged_timeago_from_reblogparenttitle_2
          "Reblogged from <a href=' '> </a>"
        end

        def reblogged_timeago_from_reblogrootname
          "Reblogged from "
        end

        def reblogged_timeago_from_reblogrootname_2
          "Reblogged from <a href=' '> </a>"
        end

        def reblogged_timeago_from_reblogroottitle
          "Reblogged from "
        end

        def reblogged_timeago_from_reblogroottitle_2
          "Reblogged from <a href=' '> </a>"
        end

        def reblogged_from
          "Reblogged from"
        end

        def reblogged_from_reblogparentname
          "Reblogged from "
        end

        def reblogged_from_reblogparentname_2
          "Reblogged from <a href=' '> </a>"
        end

        def reblogged_from_reblogparenttitle
          "Reblogged from "
        end

        def reblogged_from_reblogparenttitle_2
          "Reblogged from <a href=' '> </a>"
        end

        def reblogged_from_reblogrootname
          "Reblogged from "
        end

        def reblogged_from_reblogrootname_2
          "Reblogged from <a href=' '> </a>"
        end

        def reblogged_from_reblogroottitle
          "Reblogged from "
        end

        def reblogged_from_reblogroottitle_2
          "Reblogged from <a href=' '> </a>"
        end

        def reblogs
          "Reblogs"
        end

        def recent_comments
          "Recent comments"
        end

        def replies
          "Replies"
        end

        def search
          "Search"
        end

        def search_keywords
          "Search keywords"
        end

        def search_results_for_searchquery
          "Search results for: "
        end

        def search_results_for_searchquery_2
          "Search results for <span class='search_query'> </span>"
        end

        def searchresultcount_results
          " results"
        end

        def searchresultcount_results_for_searchquery
          " results for "
        end

        def searchresultcount_results_for_searchquery_2
          " results for <span class='search_query'> </span>"
        end

        def see_more
          "See more"
        end

        def see_more_stuff_i_like
          "See more stuff I like"
        end

        def send_email
          "Send email"
        end

        def send_me_an_email
          "Send me an email"
        end

        def send_us_an_email
          "Send us an email"
        end

        def share_this
          "Share this"
        end

        def short_url
          "Short URL"
        end

        def short_url_for_this_post
          "Short URL for this post"
        end

        def show
          "Show"
        end

        def show_all_posts_made_on_this_day
          "Show all posts made on this day"
        end

        def showing_searchresultcount_results_for_searchquery
          "Showing results for "
        end

        def showing_searchresultcount_results_for_searchquery_2
          "Showing results for <span class='search_query'> </span>"
        end

        def showing_tagresultcount_posts_tagged_tag
          "Showing posts tagged "
        end

        def showing_tagresultcount_posts_tagged_tag_2
          "Showing posts tagged <span class='tag'> </span>"
        end

        def showing_tagresultcount_posts_tagged_tag_3
          "Showing posts tagged <a href='/tagged/ ' class='tag'> </a>"
        end

        def showing_posts_tagged_tag
          "Showing posts tagged "
        end

        def showing_posts_tagged_tag_2
          "Showing posts tagged <span class='tag'> </span>"
        end

        def showing_posts_tagged_tag_3
          "Showing posts tagged <a href='/tagged/ ' class='tag'> </a>"
        end

        def sorry
          "Sorry"
        end

        def sorry_no_posts_found
          "Sorry, no posts found"
        end

        def sorry_no_results_for_searchquery
          "Sorry, no results for "
        end

        def sorry_no_results_for_searchquery_2
          "Sorry, no results for <span class='search_query'> </span>"
        end

        def sorry_no_search_results_found
          "Sorry, no search results found"
        end

        def source
          "Source"
        end

        def stuff_i_like
          "Stuff I like"
        end

        def subscribe
          "Subscribe"
        end

        def subscribe_via_rss
          "Subscribe via RSS"
        end

        def tagresultcount_posts_tagged_tag
          " posts tagged "
        end

        def tagresultcount_posts_tagged_tag_2
          " posts tagged <span class='tag'> </span>"
        end

        def tagresultcount_posts_tagged_tag_3
          " posts tagged <a href='/tagged/ ' class='tag'> </a>"
        end

        def tagged
          "Tagged"
        end

        def tagged_with
          "Tagged with"
        end

        def tags
          "Tags"
        end

        def text
          "Text"
        end

        def text_post
          "Text post"
        end

        def this_post_has_notecount_notes
          "This post has notes"
        end

        def this_post_has_notecount_notes_from_other_tumblr_users
          "This post has notes from other Tumblr users"
        end

        def this_was_posted_timeago
          "This was posted "
        end

        def timeago_with_notecount_notes
          " with notes"
        end

        def timeago_with_notecount_notes_and_playcount_plays
          " with notes and plays"
        end

        def to_the_future
          "To the future"
        end

        def to_the_past
          "To the past"
        end

        def tweet_this
          "Tweet this"
        end

        def tweets
          "Tweets"
        end

        def via
          "Via"
        end

        def video
          "Video"
        end

        def video_post
          "Video post"
        end

        def view_comments
          "View comments"
        end

        def view_comments_for_this_post
          "View comments for this post"
        end

        def view_high_resolution
          "View high resolution"
        end

        def view_notes_for_this_post
          "View notes for this post"
        end

        def view_the_discussion_thread
          "View the discussion thread"
        end

        def viewing_everything_posted_on_month_dayofmonth_year
          "Viewing everything posted on , "
        end

        def your_search_for_searchquery_returned_searchresultcount_results
          "Your search for returned results"
        end

        def your_search_for_searchquery_returned_searchresultcount_results_2
          "Your search for <span class='search_query'> </span> returned results"
        end

        def zoom
          "Zoom"
        end
      end

    end
  end
end
