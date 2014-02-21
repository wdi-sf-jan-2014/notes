require 'spec_helper'

describe "Todos" do
  describe "GET /" do
    it "should be successful" do
      get root_path
      response.status.should == 200
    end
  end
 
  describe "GET /todos" do
    it "should be successful" do
      get todos_path
      response.status.should == 200
    end
  end

  describe "POST /todos" do
    let(:data){ {todo: {title: "todo title", completed: "true"}}}
    before do
      @todo = Todo.create(title: "A test todo")
    end

    it "should post successful and return the todo item as json" do
      post "/todos.json", data
      # got a 200, the request was successful
      response.status.should == 200

      # The todo is now in the database
      todo = Todo.find_by(title: "todo title")
      todo.should_not be_nil
      todo.title.should == "todo title"
      todo.completed.should == true

      JSON.parse(response.body)["id"].should == todo.id
    end
  end

  describe "DELETE /todos/:id" do
    before do
      @todo = Todo.create!(title: "test todo", completed: false)
    end
    it "should delete the todo and return success" do
      delete "/todos/#{@todo.id}.json"
      response.status.should == 200
      expect{Todo.find(@todo.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "PATCH /todos/:id" do
    before do
      @todo = Todo.create!(title: "test todo", completed: false)
    end
    let(:data) { {completed: true} }
    it "should allow the caller to update the completed attribute on the todo" do
      patch "/todos/#{@todo.id}.json", data
      response.status.should == 200

      # Getting the updated attributes from the database
      @todo.reload
      @todo.completed.should == true

      JSON.parse(response.body)["completed"].should == true
    end
  end

end
