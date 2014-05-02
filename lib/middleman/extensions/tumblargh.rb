require 'rack/tumblargh'

module Middleman
  module Extensions
    module Tumblargh
      class << self

        def registered(app, options={})
          ::Tumblargh::API::set_api_key(options[:api_key])

          app.after_configuration do
            unless build?
              use ::Rack::Tumblargh, options
            end
          end

        end

        alias :included :registered
      end

    end
  end

  # So, page proxies don't support globs or regex matching anymore, due to how the
  # new Sitemap stuff works (at least as far as I can tell). This is what I came
  # up with as a workaround.
  module Sitemap
    class Store

      def find_resource_by_destination_path(request_path)
        request_path = "/index.html" if request_path.match(/^\/post\//)
        orig_find_resource_by_destination_path(request_path)
      end

      alias_method :orig_find_resource_by_destination_path, :find_resource_by_destination_path
    end
  end

end
