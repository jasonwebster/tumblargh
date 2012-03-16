require 'spec_helper'

require 'tumblargh'

describe Tumblargh::Parser do

  before do
    @parser = Tumblargh::Parser.new
  end

  it "should exist" do
    defined?(Tumblargh::Parser).should be_true
  end

  describe "given invalid input" do
  end

  describe "given a simple partial" do

    before do
      @parser.html = <<-eos
      {block:Text}
        {block:Title}<h1>{Title}</h1>{/block:Title}
        <p>{Body}</p>
      {/block:text}
      eos
    end

    it "should not contain any custom appearance options" do
      @parser.options.empty?.should be_true
    end

    it "should contain the following tree" do
      expected = [
        [:Literal, "      "],
        [:Block, "Text", 
          [:Block, "Title", 
            [:Literal, "<h1>"], 
            [:Tag, "Title"], 
            [:Literal, "</h1>"]
          ], 
          [:Literal, "<p>"], 
          [:Tag, "Body"], 
          [:Literal, "</p>\n      "]
        ]
      ]

      # Yes, Array.== Array is a deep value based comparison
      @parser.tree.should == expected
    end

  end

  describe "given jake's solstice theme" do

    before do
      @parser.html = open(File.join(FIXTURE_PATH, 'themes', 'solstice.html')).read
    end
    
    it "should contain the correct appearance options" do
      @parser.options.should == {
        "image" => {
          "Background" => ""
        }, 
        "if" => {
          "Show people I follow" => true,
          "Show my portrait photo" => true, 
          "Show via links with reblogged posts" => true, 
          "Use classic paging" => false, 
          "Hide Disqus comment count if zero" => false
        }, 
        "text" => {
          "Disqus Shortname" => "",
          "Google Analytics ID" => ""
        }
      }
    end

    it "should contain exacty one 'posts' block" do
      nodes = @parser.tree
      matches = nodes.select do |n|
        n[0] == :Block && n[1] == "Posts"
      end

      matches.size.should eql 1
    end
    
  end

end
