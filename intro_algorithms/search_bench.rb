require './bsearch.rb'

# Print CSV header
puts "Array Size, Binary Search, Linear Search"
# Choose set of array sizes
for array_size in [2,4,8,10,25,50,75,100,225,350,500,1000,10000,100000]
  # We will search n_searches times at each size and average the time
  n_searches = 100

  binary_search_total = 0
  linear_search_total = 0

  n_searches.times do
    # generate an array of random numbers of the correct size
    array = (0...array_size).map{rand(1000000)}.sort

    search_target = array.sample

    time = Time.now
    ind = binary_search(array, search_target)
    binary_search_total += Time.now - time

    time = Time.now
    # Use the built in Array#index linear search method
    ind2 = array.index(search_target)
    linear_search_total += Time.now - time
  end

  puts [array_size, binary_search_total/n_searches, linear_search_total/n_searches].join(",")
end
