# Description
#   A bot to keep track (checkin and checkout) resources.
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   hubot checkout - <checkout a resource>
#   hubot return - <return a resource>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   deekim <todankim@gmail.com>

module.exports = (robot) ->
  robot.respond /hello/, (res) ->
    res.reply "hi from checkout!"

  robot.respond /checkout (.*)/, (res) ->
    username = res.message.user.name
    resourceName = res.match[1]
    resource = robot.brain.get('resource-' + resourceName)

    if resource === null
      robot.brain.set('resource-' + resourceName, username)
      res.reply username + "checked out " + resourceName
    else
      res.reply "Seems like " + resourceName + " is already checked out by " + resource + "."


  robot.respond /return (.*)/, (res) ->
    username = res.message.user.name
    resourceName = res.match[1]
    resource = robot.brain.get('resource-' + resourceName)

    if resource === null
      res.reply username + " returned " + resourceName
    else
      robot.brain.remove('resource-' + resourceName)
      res.reply username + " returned " + resourceName
  