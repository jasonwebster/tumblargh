# require 'action_view/helpers/date_helper'

module Tumblargh
  module Renderer
    module Blocks

      # Rendered for all posts.
      # Always wrap dates in this block so they will be properly hidden on non-post pages.
      class Date < Base

        MAP = {
          # Tumblr tag => strftime symbol
                    :day_of_month => '-d',
          :day_of_month_with_zero => :d,
                     :day_of_week => :A,
               :short_day_of_week => :a,
              :day_of_week_number => :u,
                     :day_of_year => '-j',
                    :week_of_year => '-V',
                           :month => :B,
                     :short_month => :b,
                    :month_number => '-m',
          :month_number_with_zero => :m
        }

        MAP.each_pair do |tag, sym|
          define_method tag do
            context.date.strftime("%#{sym}")
          end
        end

        def day_of_month_suffix
          day_of_month.to_i.ordinalize
        end

        def year
          date.year
        end

        def short_year
          year.to_s[2..4]
        end

        def time_ago
          # ActionView::Helpers::DateHelper::time_ago_in_words(date)
          "1 day ago"
        end

      end

      # Rendered for posts that are the first to be listed for a given day.
      class NewDayDate < Base
      end

      # Rendered for subsequent posts listed for a given day.
      class SameDayDate < Base
      end

    end
  end
end

