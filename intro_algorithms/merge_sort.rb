def merge_sort(array)
  if array.size <= 1
    return array
  else
    mid = array.size/2
    left = merge_sort(array[0,mid])
    right = merge_sort(array[mid, array.size])
    return merge(left, right)
  end
end

def merge(left, right)
  out = []
  while left.size > 0 && right.size > 0
    if left.first < right.first
      out.push(left.shift)
    else
      out.push(right.shift)
    end
  end
  # Now either left, right, or both are empty
  if right.empty?
    out += left
  else
    out += right
  end

  return out
end

