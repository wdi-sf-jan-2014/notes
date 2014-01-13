require 'rspec'
require './merge_sort.rb'

def is_sorted?(array)
  for i in 1...array.length
    puts i
    return false if array[i] < array[i-1]
  end
  return true
end

describe 'sort' do
  it 'sorts an empty array' do
    is_sorted?(merge_sort([])).should == true
  end

  it 'sorts a small array' do
    arr = [40, 64, 49, 3]
    sorted_arr = merge_sort(arr)
    is_sorted?(sorted_arr).should == true
    sorted_arr.length.should == arr.length
    sorted_arr.should == [3,40,49,64]
  end

  it 'sorts a bigger array' do
    arr = [88, 83, 38, 9, 64, 65, 72, 90, 18, 18, 75]
    sorted_arr = merge_sort(arr)
    is_sorted?(sorted_arr).should == true
    sorted_arr.length.should == arr.length
    sorted_arr.should == [9, 18, 18, 38, 64, 65, 72, 75, 83, 88, 90]
  end
end
