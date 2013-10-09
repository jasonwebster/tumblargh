require 'spec_helper'

describe Tumblargh::Resource::Photo do
  include_context 'staff.tumblr.com'

  subject { posts.first.photos.first }

  it 'should be aware of alt size width' do
    subject.photo_width(250).should eql 250
  end

  it 'should be aware of alt size height' do
    subject.photo_height(500).should eql 334
  end

  describe '#find_size' do
    it 'should find a size that exists' do
      subject.send(:find_size, 500).should have_key :url
    end

    it 'should return nil for a size that does not exist' do
      subject.send(:find_size, 501).should be_nil
    end
  end

end
