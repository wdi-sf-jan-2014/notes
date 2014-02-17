var Iterators = (function() {
  return {
    each: function (arr, action) {
      if (arr === null) return arr;
      for (var i=0;i<arr.length;i++) {
        action(arr[i]);
      }
      return arr;
    }
  };
})();