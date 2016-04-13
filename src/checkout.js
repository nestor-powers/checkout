module.exports = function(robot) {
  var resourceMatch = /^resource-(.+)$/i;

  robot.respond(/list resources?/i, function(res, done) {
    var data = robot.brain.data._private;
    var response = "";
    var count = 0;

    for (var key in data) {
      var value = data[key];
      var resource = resourceMatch.exec(key);
      if (resource !== null) {
        response += "'" + resource[1] + "' was checked out by <@" + value + ">\n";
        count++;
      }
    }

    if(count == 0) {
      response = "No resources have been checked out";
    }

    res.reply(response, done);
  });

  robot.respond(/checkout (.+)/i, function(res, done) {
    var username = res.message.user.name;
    var resourceName = res.match[1];
    var resourceUser = robot.brain.get('resource-' + resourceName);

    if (resourceUser === null) {
      robot.brain.set('resource-' + resourceName, username);
      res.reply(" <@" + username + "> checked out " + resourceName, done);
    } else {
      res.reply("Seems like " + resourceName + " is already checked out by <@" + resourceUser + ">.", done);
    }
  });

  robot.respond(/return(?! --force) (.+)/i, function(res, done) {
    var username = res.message.user.name;
    var resourceName = res.match[1];
    var resourceUser = robot.brain.get('resource-' + resourceName);

    if (resourceUser === null) {
      res.reply("'" + resourceName + "' does not appear to be checked out", done);
    } else if (resourceUser === username) {
      robot.brain.remove('resource-' + resourceName);
      res.reply("<@" + resourceUser + "> returned " + resourceName, done);
    } else {
      res.reply("'" + resourceName + "' is checked out by <@" + resourceUser + ">.", done);
    }
  });

  robot.respond(/return --force (.+)/i, function(res, done) {
    var username = res.message.user.name;
    var resourceName = res.match[1];
    var resourceUser = robot.brain.get('resource-' + resourceName);

    if (resourceUser === null) {
      res.reply("'" + resourceName + "' does not appear to be checked out", done);
    } else {
      robot.brain.remove('resource-' + resourceName);
      res.reply("<@" + username + "> forcefully returned " + resourceName, done);
    }
  });
};
