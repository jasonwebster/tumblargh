require 'spec_helper'


describe Tumblargh::Renderer::Blocks do

  before do
    @parser = Tumblargh::Parser.new
  end

  describe "{block:PermalinkPage}" do
    before do
      @parser.html = <<-eos
        {block:PermalinkPage}
        ERMAGERD PERMERLINK
        {/block:PermalinkPage}
        eos
    end

    it "should render its content when it is a permalink page" do
      @document = Tumblargh::Renderer::Document.new(@parser.tree, nil, :permalink => true)
      @output = @document.render
      @output.should match(/ERMAGERD PERMERLINK/)
    end

    it "should NOT render its content when it is a permalink page" do
      @document = Tumblargh::Renderer::Document.new(@parser.tree, nil, :permalink => false)
      @output = @document.render
      @output.should_not match(/ERMAGERD PERMERLINK/)
    end

  end

  describe "boolean blocks" do

    before do
      @parser.html = <<-eos
      {block:IfSomethingOnByDefault}
      PASS_ON
      {/block:IfSomethingOnByDefault}

      {block:IfSomethingOffByDefault}
      FAIL_OFF
      {/block:IfSomethingOffByDefault}

      {block:IfNotSomethingOnByDefault}
      FAIL_INVERSE_ON
      {/block:IfNotSomethingOnByDefault}

      {block:IfNotSomethingOffByDefault}
      PASS_INVERSE_OFF
      {/block:IfNotSomethingOffByDefault}
      eos

      options = {
        "if" => {
          "somethingonbydefault" => true,
          "somethingoffbydefault" => false
        }
      }

      @document = Tumblargh::Renderer::Document.new(@parser.tree, nil, options)
      @output = @document.render
    end

    it "should respect the default settings" do
      @output.should match(/PASS_ON/)
      @output.should_not match(/FAIL_OFF/)
    end


    it "inverse (IfNot) blocks should work" do
      @output.should_not match(/FAIL_INVERSE_ON/)
      @output.should match(/PASS_INVERSE_OFF/)
    end

  end

end
