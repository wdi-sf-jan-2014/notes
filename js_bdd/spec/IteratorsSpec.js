describe("Iterators", function() {
  it("works!", function() {
    expect(true).toBe(true);
  });
  describe(".each", function() {
    describe("given a null", function() {
      it("returns null", function() {
        expect(Iterators.each(null)).toBeNull();
      });
    });
    describe("given an array and an action as input", function() {
      var arr = [1,2,3,4], action = jasmine.createSpy('action');
      it("returns the array", function() {
        expect(Iterators.each(arr,action)).toBe(arr);
      });
      it("applies the action to each of the elements in array", function() {
        expect(action.calls.allArgs()).toEqual([[1],[2],[3],[4]]);
      });
    });
  });

  describe(".map", function() {
    describe("given a null", function() {
      it("returns null", function() {
        pending();
      });
    });
    describe("given an array and an action as input", function() {
      it("returns a new array", function() {
        pending();
      });
      it("returned array has results of the action applied to each element of the input array", function() {
        pending();
      });
      it("does not modify the original array at all", function() {
        pending();
      });
    });
  });
});