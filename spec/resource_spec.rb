require 'spec_helper'

describe Tumblargh::Resource do

  describe "using local data" do

    before do
      json_path = File.join(FIXTURE_PATH, "data", "staff.tumblr.com-2012-05-06", "posts.json")
      @json = ActiveSupport::JSON.decode(open(json_path).read)["response"]
    end

    it "should not have to fall back to the API" do
      Tumblargh::API.disable!

      blog = Tumblargh::Resource::Blog.new("staff.tumblr.com", @json)
      lambda { blog.posts }.should_not raise_error

      Tumblargh::API.enable!
    end

  end

end
