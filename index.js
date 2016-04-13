var path = require('path');

module.exports = function(robot) {
  robot.loadfile(path.resolve(__dirname, "src"), "checkout.js");
};
