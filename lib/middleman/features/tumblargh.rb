require 'rack/tumblargh'

module Middleman::Features::Tumblargh
  class << self

    def registered(app, options={})
      app.extend ClassMethods
      app.use Rack::Tumblargh
    end

    alias :included :registered

    module ClassMethods
      def tumblr_api_key=(key)
        Tumblargh::API::set_api_key(key)
      end

      alias_method :set_tumblr_api_key, :tumblr_api_key=
    end

  end
end
