require 'spec_helper'

require 'tumblargh'

describe Tumblargh do

  describe "using the renderer shortcuts" do

  it "should raise an exception if called without setting an api key" do
    lambda { Tumblargh::render_html('', 'staff.tumblr.com') }.should raise_error
  end

  end

end
