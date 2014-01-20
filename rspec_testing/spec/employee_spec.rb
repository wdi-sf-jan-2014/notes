require 'employee'
require 'spec_helper'

describe Employee do

  before(:each) do
    @employee = Employee.new("YourName")
    @employee1 = Employee.new("Micky")
  end

  it "has an name" do
    @employee.name.should eq("YourName")
    # employee.name.should == "YourName"
  end

  it "can change names" do
    @employee.name = "Donald"
    @employee.name.should eq("Donald")
  end

  it "introduces itself" do
    @employee.introduce.should == "Hi, my name is YourName."
  end

  it "updates employee count" do
    Employee.count.should == 2
  end

  after(:each) do
    Employee.resign
    Employee.resign
  end
end

