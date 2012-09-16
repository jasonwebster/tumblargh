require 'spec_helper'


describe Tumblargh::Renderer::Document do

  describe "permalink pages" do

    before do
      @parser = Tumblargh::Parser.new
      @parser.html = ""

      @document = Tumblargh::Renderer::Document.new(@parser.tree, nil, :permalink => true)
    end

    it "the document should know this is a permalink page" do
      @document.permalink?.should be_true
    end

  end

end
