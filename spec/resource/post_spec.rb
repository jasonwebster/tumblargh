require 'spec_helper'

describe Tumblargh::Resource::Post do
  
  before do
    json_path = File.join(FIXTURE_PATH, "data", "staff.tumblr.com-2012-05-06", "posts.json")
    @json = ActiveSupport::JSON.decode(open(json_path).read)["response"]
    @blog = Tumblargh::Resource::Blog.new("staff.tumblr.com", @json)
    @posts = @blog.posts
  end

  it "should have an instance of Time for its date attribute" do
    @posts.each do |post|
      post.date.should be_an_instance_of Time
    end
  end

  it "should always return an array of tags" do
    @posts.each do |post|
      post.tags.should be_an_instance_of Array
    end
  end

  it "should correctly parse the number of tags" do
    @posts.each do |post|
      post.tags.size.should eql post.attributes[:tags].size
    end
  end

  it "should have the correct tag names" do
    @posts.each do |post|
      post.tags.map(&:name).should == post.attributes[:tags]
    end
  end

  it "should give the tags as class names" do
    @posts.each do |post|
      tags = post.tags_as_classes

      if post.tags.any?
        post.tags.collect { |t| 
          t.name.titlecase.gsub(/\s+/, '').underscore.downcase 
        }.join(" ").should == tags
      end
    end
  end


end
