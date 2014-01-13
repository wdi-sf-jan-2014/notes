class SortedArray
  def each &block
    puts "in SortedArray#each"
    # counter for retrieving array elements
    i = 0
    # use a built in loop, terminating condition is array size
    until i == size
      # invoke the block, passing the value at the current index
      yield self[i]
      # increment i to the next index
      i += 1
    end
    
    # return the array back
    self
  end
  
  def map &block
    puts "in SortedArray#map"
    # gotta keep track of the elements
    i = 0
    # cloned array
    clone = self.dup
    # use each to iterate
    clone.each do |el|
      # replace element at current position after invoking block on it
      clone[i] = yield el
      # increment the position
      i += 1
    end 
    # return the cloned array back
    clone
  end

  def find
    each do |value|
      return value if yield(value)
    end
    nil
  end
end
