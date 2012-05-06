require 'spec_helper'

describe Tumblargh do

  describe "specifying the source blog/data" do

    it "should work with local blog data from a file" do
      json_path = File.join(FIXTURE_PATH, "data", "staff.tumblr.com-2012-05-06", "posts.json")

      blog = Tumblargh.send(:create_blog, json_path)

      blog.should be_an_instance_of Tumblargh::Resource::Blog
      blog.title.should eql "Tumblr Staff"
    end

    it "should work when passing in a hash" do
      json_path = File.join(FIXTURE_PATH, "data", "staff.tumblr.com-2012-05-06", "posts.json")
      json = ActiveSupport::JSON.decode(open(json_path).read)

      blog = Tumblargh.send(:create_blog, json)

      blog.should be_an_instance_of Tumblargh::Resource::Blog
      blog.title.should eql "Tumblr Staff"
    end

    it "should work when passing in a Blog object" do
      json_path = File.join(FIXTURE_PATH, "data", "staff.tumblr.com-2012-05-06", "posts.json")
      json = ActiveSupport::JSON.decode(open(json_path).read)["response"]
      obj = Tumblargh::Resource::Blog.new("#{json["blog"]["name"]}.tumblr.com", json)

      blog = Tumblargh.send(:create_blog, obj)

      blog.should be_an_instance_of Tumblargh::Resource::Blog
      blog.title.should eql "Tumblr Staff"
    end

    it "should work by simply passing a tumblr domain" do
      Tumblargh::API.set_api_key TUMBLR_API_KEY

      blog = Tumblargh.send(:create_blog, "staff.tumblr.com")

      blog.should be_an_instance_of Tumblargh::Resource::Blog
      blog.title.should eql "Tumblr Staff"

      Tumblargh::API.set_api_key nil
    end

  end

end
