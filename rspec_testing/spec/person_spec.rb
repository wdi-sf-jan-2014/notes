require 'person'
require 'spec_helper'

describe "Person" do

  before(:each) do
    @person = Person.new("Jim", 25)
    @person1 = Person.new("Jane", 28)
  end

  context "class" do

    it "has a class variable keeping track of the population" do
      Person.population.should == 2
    end

    it "has a say_hello class method" do
      Person.say_hello.should == "Hello world!"
    end
  end



  context "when first created" do

    it "has a name attribute" do
      @person.name.should == "Jim"
    end

    it "has an age attribute" do
      @person.age.should == 25
    end

    it "has an introduction method" do
      introduction = @person.introduction
      introduction.should == "Hi, my name is Jim and I am 25 years old."
    end
  end

  context "when modified" do
    it "can update age attribute" do
      @person.age = 26
      @person.age.should eq(26)
    end

    it "can change name" do
      @person.name = "James"
      @person.name.should eq("James")
    end
  end

  after(:each) do
    @person.remove
    @person1.remove
  end

end
