require 'spec_helper'

describe "Todos" do
  describe "GET /todos" do
    it "should be successful" do
      get todos_path
      response.status.should == 200
    end

    it "displays todos" do
      Todo.create!(title: "Red: Write specs and see them fail")
      get todos_path 
      response.body.should include("Red: Write specs and see them fail")
    end
  end

  describe "GET /todos/:id/show" do
    context "given a todo id" do
      before do
        @todo = Todo.create!(title: "Green: Get the specs to pass")
        get todos_path(@todo.id)
      end

      it "should be successful" do
        response.status.should == 200
      end

      it "should be display the todo" do
        response.body.should include("Green: Get the specs to pass")
      end
    end
  end

  describe "POST /todos" do
    context "given a todo in the params" do
      before do
        post todos_path, todo: { title: "Refactor: Clean up your code" }
      end

      it "should be successful" do
        follow_redirect!
        response.status.should == 200
      end

      it "should create the todo" do
        response.body.should include("Refactor: Clean up your code")
      end
    end
  end
end
