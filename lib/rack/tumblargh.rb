module Rack
  class Tumblargh

    def initialize(app, options={})
      @app = app
      @options = options
      @options[:blog] = 'staff.tumblr.com' if @options[:blog].nil?
    end

    attr_reader :options

    def call(env)
      request = Rack::Request.new(env)

      ['/tweets.js', %r{/api.*}].each do |route|
        if request.path.match route
          url = "http://#{@options[:blog]}#{request.path}?#{request.query_string}"
          return [301, { "Location" => url }, []]
        end
      end

      status, headers, response = @app.call(env)

      if should_parse?(status, headers)
        content = response.respond_to?(:body) ? response.body : response
        render_opts = { :permalink => permalink?(env['PATH_INFO']) }

        headers.delete('Content-Length')
        response = Rack::Response.new(
          render(content, render_opts),
          status,
          headers
        )
        response.finish
        response.to_a
      else
        [status, headers, response]
      end
    end

  private

    def permalink?(path)
      !! path.match(/^\/post\/\d+/)
    end

    def should_parse?(status, headers)
      status == 200 && 
      headers["Content-Type"] && 
      headers["Content-Type"].include?("text/html")
    end

    def render(content, opts)
      ::Tumblargh::render_html(content.first, options[:blog], opts)
    end

  end
end
