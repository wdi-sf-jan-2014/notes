
def binary_search(arr, target, start_ind=0, end_ind=arr.length)
  # If start_ind > end_ind, the target can't be in the search space.
  return nil unless start_ind < end_ind

  # Calculate the halfway point
  mid_ind = (end_ind-start_ind)/2 + start_ind

  # Get the halfway element
  mid_ele = arr[mid_ind]

  # Is the target right in the middle?
  if mid_ele == target
    mid_ind # return it.
  elsif mid_ele > target
    # Since the middle element is > than the target
    # We know the target is in the left half of the search space
    binary_search(arr, target, start_ind, mid_ind)
  elsif mid_ele < target
    # Since the middle element is < than the target
    # We know the target is in the right half of the search space
    binary_search(arr, target, mid_ind + 1, end_ind)
  end
end


def binary_search_loop(arr, target, start_ind=0, end_ind=arr.length)
  # If start_ind > end_ind, the target can't be in the search space.
  until start_ind >= end_ind
    # Calculate the halfway point
    mid_ind = (end_ind-start_ind)/2 + start_ind
    # Get the halfway element
    mid_ele = arr[mid_ind]
    # Is the target right in the middle?
    if mid_ele == target
      return mid_ind # return it.
    elsif mid_ele > target
      # Since the middle element is > than the target
      # We know the target is in the left half of the search space
      end_ind = mid_ind
    elsif mid_ele < target
      # Since the middle element is < than the target
      # We know the target is in the right half of the search space
      start_ind = mid_ind + 1
    end
  end
  return nil
end
