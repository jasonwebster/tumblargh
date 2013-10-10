require 'spec_helper'


describe Tumblargh::Renderer::Blocks do

  def capture_stdout(&block)
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    fake.string
  end

  let(:parser) { Tumblargh::Parser.new }

  describe "{block:PermalinkPage}" do
    before do
      parser.html = <<-eos
        {block:PermalinkPage}
        ERMAGERD PERMERLINK
        {/block:PermalinkPage}
        eos
    end

    it "should render its content when it is a permalink page" do
      document = Tumblargh::Renderer::Document.new(parser.tree, nil, :permalink => true)
      output = document.render
      output.should match(/ERMAGERD PERMERLINK/)
    end

    it "should NOT render its content when it is a permalink page" do
      document = Tumblargh::Renderer::Document.new(parser.tree, nil, :permalink => false)
      output = document.render
      output.should_not match(/ERMAGERD PERMERLINK/)
    end
  end

  describe "boolean blocks" do
    before do
      parser.html = <<-eos
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
    end

    let(:options) do
      {
        "if" => {
          "somethingonbydefault" => true,
          "somethingoffbydefault" => false
        }
      }
    end

    let(:output) { Tumblargh::Renderer::Document.new(parser.tree, nil, options).render }

    it "should respect the default settings" do
      output.should match(/PASS_ON/)
      output.should_not match(/FAIL_OFF/)
    end


    it "inverse (IfNot) blocks should work" do
      output.should_not match(/FAIL_INVERSE_ON/)
      output.should match(/PASS_INVERSE_OFF/)
    end
  end

  describe "using unsupported blocks" do
    before do
      parser.html = <<-eos
      {block:ThisIsDefinitelyNotABlock}{/block:ThisIsDefinitelyNotABlock}
      eos
    end

    it "should not raise an error" do
      expect {
        Tumblargh::Renderer::Document.new(parser.tree, nil, {}).render
      }.not_to raise_error
    end

    it "should output a warning" do
      out = capture_stdout {
        Tumblargh::Renderer::Document.new(parser.tree, nil, {}).render
      }

      out.should =~ /WARNING: Unsupported block `Tumblargh::Renderer::Blocks::ThisIsDefinitelyNotABlock`/
    end

  end
end
