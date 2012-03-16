require 'rack/tumblargh'

module Middleman::Features::Tumblargh

  class << self

    def registered(app)
      options = {}
      app.set(:tumblr_options, options)
      app.extend(ClassMethods)
      app.use(Rack::Tumblargh, options) unless app.build?
    end

    alias :included :registered

    module ClassMethods
      def tumblr_api_key=(key)
        Tumblargh::API::set_api_key(key)
      end

      def tumblr_blog=(blog=nil)
        tumblr_options[:blog] = blog
      end

      alias_method :set_tumblr_api_key, :tumblr_api_key=
      alias_method :set_tumblr_blog, :tumblr_blog=
    end

  end
end