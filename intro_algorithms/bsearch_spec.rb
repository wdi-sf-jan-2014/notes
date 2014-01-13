require 'rspec'
require './bsearch.rb'

describe 'Recursive Binary Search' do
  before do
    @array = [4, 67, 77, 4, 7, 5, 14, 17, 51, 77,
              64, 24, 22, 56, 31, 25, 29, 36, 95, 79]
    @sorted_array = @array.sort
  end

  it 'finds one element in a single element array' do
    binary_search([1], 1).should == 0
  end
  it 'should find the target element' do
    target = @array[12]
    ind = binary_search(@sorted_array, target)
    @sorted_array[ind].should == target
  end

  it 'should return nil on a non-element' do
    binary_search(@sorted_array, 20).should == nil
  end
  it 'excludes end_ind' do
    binary_search(@sorted_array, @sorted_array[10], 0, 10).should == nil
  end
  it 'includes start_ind' do
    binary_search(@sorted_array, @sorted_array[5], 5, 10).should == 5
  end
end

describe 'Looping Binary Search' do
  before do
    @array = [4, 67, 77, 4, 7, 5, 14, 17, 51, 77,
              64, 24, 22, 56, 31, 25, 29, 36, 95, 79]
    @sorted_array = @array.sort
  end

  it 'finds one element in a single element array' do
    binary_search_loop([1], 1).should == 0
  end
  it 'should find the target element' do
    target = @array[12]
    ind = binary_search_loop(@sorted_array, target)
    @sorted_array[ind].should == target
  end

  it 'should return nil on a non-element' do
    binary_search_loop(@sorted_array, 20).should == nil
  end
  it 'excludes end_ind' do
    binary_search_loop(@sorted_array, @sorted_array[10], 0, 10).should == nil
  end
  it 'includes start_ind' do
    binary_search_loop(@sorted_array, @sorted_array[5], 5, 10).should == 5
  end
end
