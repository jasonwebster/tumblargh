require 'spec_helper'

describe Tumblargh do

  describe "using the renderer shortcuts" do

    describe "without an api key" do
      before do
        # Since api_key is a global, need to clear it out here.
        # It may have been set in other tests
        Tumblargh::API.set_api_key nil
      end

      it "should raise an exception" do
        lambda { Tumblargh::render_html('', 'staff.tumblr.com') }.should raise_error
      end

    end

  end

end
