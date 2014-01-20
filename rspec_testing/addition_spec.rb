require './addition_methods'

describe "Addition Methods" do

  context "add_two_variables method" do
    it "returns the correct value" do
      add_two_variables().should == 7
    end
  end

  context "add_two_arguments method" do
    it "adds 5 + 6 to get 11" do
      add_two_arguments(5,6).should == 11
    end

    it "adds 5 + 6 should not get 12" do
      add_two_arguments(5,6).should_not == 12
    end
  end
end
