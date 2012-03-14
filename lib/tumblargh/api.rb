require 'active_support'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/to_query'
require 'active_support/json'

require 'open-uri'

module Tumblargh
  module API

    API_ROOT = 'http://api.tumblr.com/v2/blog/'

    autoload :Base,      'tumblargh/api/base'
    autoload :Blog,      'tumblargh/api/blog'
    autoload :User,      'tumblargh/api/user'
    autoload :Post,      'tumblargh/api/post'
  
    class << self

      attr_accessor :api_key
      alias_method :set_api_key, :api_key=

      def fetch(path, query={})
        query.merge!(:api_key => api_key)
        url = "#{API_ROOT}#{path}?#{query.to_query}"
        # puts "Fetching: #{url} ..."
        ActiveSupport::JSON.decode( open(url).read )['response']
      end
    end


  end
end
