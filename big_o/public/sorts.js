function mergeSort(arr){
  arr = arr || this;
  if (arr.length < 2)
    return arr;

  var middle = ~~(arr.length / 2);
  var left  = arr.slice(0, middle);
  var right = arr.slice(middle, arr.length);

  return merge(mergeSort(left), mergeSort(right));
}

function merge(left, right)
{
  var result = [];

  while (left.length && right.length) {
    if (left[0] <= right[0]) {
      result.push(left.shift());
    } else {
      result.push(right.shift());
    }
  }

  while (left.length)
    result.push(left.shift());

  while (right.length)
    result.push(right.shift());

  return result;
}

function bubbleSort()
{
  var didSwap = true;
  while(didSwap){
    didSwap = false;
    for (var i=0; i < this.length-1; i++) {
      if (this[i] > this[i+1]) {
        var temp = this[i];
        this[i] = this[i+1];
        this[i+1] = temp;
        didSwap = true;
      }
    }
  }
}


// From Wikipedia
function selectionSort ()
{
  for (var i = 0; i < this.length - 1; i++)
  {
    var smallestIndex = i;
    for (var j = i + 1; j < this.length; j++){
      if (this[j] < this[smallestIndex]){
        smallestIndex = j;
      }
    }

    var tmp = this[smallestIndex];
    this[smallestIndex] = this[i];
    this[i] = tmp;
  }
}
