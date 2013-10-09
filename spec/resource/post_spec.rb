require 'spec_helper'

describe Tumblargh::Resource::Post do
  include_context "staff.tumblr.com"

  it "should have an instance of Time for its date attribute" do
    posts.each do |post|
      post.date.should be_an_instance_of Time
    end
  end

  it "should always return an array of tags" do
    posts.each do |post|
      post.tags.should be_an_instance_of Array
    end
  end

  it "should correctly parse the number of tags" do
    posts.each do |post|
      post.tags.size.should eql post.attributes[:tags].size
    end
  end

  it "should have the correct tag names" do
    posts.each do |post|
      post.tags.map(&:name).should == post.attributes[:tags]
    end
  end
end
