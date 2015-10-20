require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:event) { Event.create!( :name => "test", :friendly_id => "test" )  }

  describe "tag_list" do
    it "should get blank tag_list" do
      expect( event.tag_list ) .to eq("")
    end

    it "should get one tag_list" do
      tag = Tag.create!( :name => "foo" )
      event.taggings.create!( :tag => tag )

      expect( event.tag_list ) .to eq("foo")
    end

    it "should get more tag_list" do
      tag1 = Tag.create!( :name => "foo" )
      tag2 = Tag.create!( :name => "bar" )
      event.taggings.create!( :tag => tag1 )
      event.taggings.create!( :tag => tag2 )

      expect( event.tag_list ) .to eq("foo,bar")
    end
  end

  describe "tag_list=" do
    it "assign one tag_list" do
      event.tag_list = "zar"
      event.save

      expect( event.tag_list ).to eq("zar")
    end

    it "assign many tag_list" do
      event.tag_list = "a,b,c,d"
      event.save

      expect( event.tag_list ).to eq("a,b,c,d")
    end

  end
end
