require 'spec_helper'

describe "Todos" do
  describe "GET /todos" do
    it "should be successful" do
      get todos_path
      response.status.should == 200
    end

    it "displays todos" do
      Todo.create!(title: "Write specs")
      get tasks_path
      response.body.should include("Write specs")
    end
  end

  describe "POST /todos" do
    it "should be successful" do
      post todos_path, todo: { title: "Get the specs to pass" }
      follow_redirect!
      response.status.should == 200
    end

    it "should create the todo" do
      post todos_path, todo: { title: "Get the specs to pass" }
      response.body.should include("Get the specs to pass")
    end
  end
end
