require 'rack/tumblargh'

module Middleman
  module Extensions::Tumblargh
    class << self

      def registered(app, options={})
        Tumblargh::API::set_api_key(options[:api_key])

        app.after_configuration do
          unless build?
            use Rack::Tumblargh, options
            page '/post/*', :proxy => '/index.html'
          end
        end
      end

      alias :included :registered

    end
  end

end
