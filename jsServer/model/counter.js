
let count = 0;



module.exports = {
  getCounter: function () {

    count++;
    return count;

  },
  setCounter: function(num) {
    count = num;
  }
};