require 'spec_helper'


describe Tumblargh::Parser do

  before do
    @parser = Tumblargh::Parser.new
  end

  it "should exist" do
    defined?(Tumblargh::Parser).should be_true
  end

  describe "given invalid input" do

    it "should throw an error if there is an unclosed block" do
      @parser.html = <<-eos
      {block:Text}
        {block:Title}<h1>{Title}</h1>{block:Title}
        <p>{Body}</p>
      {/block:text}
      eos

      lambda { @parser.tree }.should raise_error Tumblargh::ParserError
    end

  end

  describe "given something that kinda looks like a tag but isn't" do

    before do
      @parser.html = "<div>{CustomCSS</div>"
    end

    it "should NOT throw an error if there is a malformed tag" do
      lambda { @parser.tree }.should_not raise_error Tumblargh::ParserError
    end

    it "should generate the following tree" do
      @parser.tree.should == [[:Literal, "<div>"], [:Literal, "{"], [:Literal, "CustomCSS</div>"]]
    end

  end

  describe "when given a bunch of css" do

    before do
      @input = <<-eos
      .container{*zoom:1;margin:auto;width:960px;max-width:100%;position:relative}.container:after{content:"";display:table;clear:both}.dot-sprite,#clients .nav .dots li,#clients .nav .dots li.active,#fullscreen_nav .nav .dots li,#fullscreen_nav .nav .dots li.active{background:url('../images/dot-sa49b299bc4.png') no-repeat}body.index{min-width:1000px}body.fullscreen{overflow-x:hidden}#clients{height:461px;overflow:visible;background:#fff url('../images/homepage-clients-bg.png') repeat-x 0 0px}#clients .frame{width:958px;height:448px;margin:0 auto;position:relative;-moz-border-radius:7px;-webkit-border-radius:7px;-o-border-radius:7px;-ms-border-radius:7px;-khtml-border-radius:7px;border-radius:7px;-moz-box-shadow:#000 0px 1px 2px;-webkit-box-shadow:#000 0px 1px 2px;-o-box-shadow:#000 0px 1px 2px;box-shadow:#000 0px 1px 2px;background:#262626}

        #title a{
          text-decoration:none;
          color:#fff;
          font-weight:bold;
          text-shadow: #fff 0px 1px 0px;
          padding:0;
          display:block;
        }

        #title b {height:93px;
          width:36px;
          position: absolute;
          top:0px;
        }

        #title b.left {
          background: url(http://static.tumblr.com/xsp9wak/Shikloi1h/background-title.png) top left;
          left:-36px; }

        #title b.right {right:-36px;}
      eos

      @parser.html = @input
    end

    it "should NOT throw an error" do
      lambda { @parser.tree }.should_not raise_error Tumblargh::ParserError
    end

    it "its output should match its input" do
      @parser.to_s.should eql @input
    end

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
