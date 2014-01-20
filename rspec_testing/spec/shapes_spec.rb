require 'shapes'
require 'spec_helper'

describe Shape do

  before do
    @shape = Shape.new(4,[2,3,4,5])
  end

  context "when created" do
    it "has perimeter" do
      @shape.get_perimeter.should eq(14)
    end
  end
end

describe Square do

  square = Square.new(5)

  context "when created" do
   it "has perimeter" do
    square.get_perimeter.should eq(20)
   end

   it "has area" do
    square.get_area.should eq(25)
   end
  end
end

