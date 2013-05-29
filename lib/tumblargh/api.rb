require 'active_support'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/to_query'
require 'active_support/json'

require 'api_cache'
require 'open-uri'

module Tumblargh
  module API

    API_ROOT = 'http://api.tumblr.com/v2/blog/'

    @enabled = true

    class << self

      attr_accessor :api_key
      alias_method :set_api_key, :api_key=

      def fetch(path, query={})
        raise "API is disabled" unless enabled?

        query = query.merge(:api_key => api_key).to_query
        url = "#{API_ROOT}#{path}?#{query}"
        resp = APICache.get(url) { open(url).read }
        ActiveSupport::JSON.decode(resp)['response']
      end

      def blog(domain)
        fetch("#{domain}/info")['blog']
      end

      def posts(domain, query={})
        fetch("#{domain}/posts")['posts']
      end

      def notes(domain, query)
        query.merge!(:notes_info => 'true')
        fetch("#{domain}/posts", query)['posts'][0]['notes']
      end

      def enable!
        @enabled = true
      end

      def disable!
        @enabled = false
      end

      def enabled?
        @enabled
      end

    end


  end
end
