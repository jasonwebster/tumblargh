require 'spec_helper'

require 'tumblargh/parser'

describe Tumblargh::Parser do

  before do
    @parser = new Tumblargh::Parser
  end

  it "should exist" do
    defined?(Tumblargh::Parser).should be_true
  end

  describe "when given invalid input" do
  end

  describe "extracting appearance configuration" do

    before do
      @parser.html = open('fixtures/solstice.html').read
    end
    
    
  end

end
