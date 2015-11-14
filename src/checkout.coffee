# Description
#   A bot to keep track (checkin and checkout) resources.
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot checkout <resource> - checks out <resource>
#   hubot return <resource> - returns <resource>
#   hubot resource list - lists checked out resources
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   deekim <todankim@gmail.com>

module.exports = (robot) ->

  robot.respond /resource list/i, (res) ->
    console.log robot.brain.data

  robot.respond /checkout (.*)/i, (res) ->
    username = res.message.user.name
    resourceName = res.match[1]
    resourceUser = robot.brain.get('resource-' + resourceName)

    if resourceUser == null
      robot.brain.set('resource-' + resourceName, username)
      res.reply " checked out " + resourceName
    else
      res.reply "Seems like " + resourceName + " is already checked out by " + resourceUser + "."

  robot.respond /return (.*)/i, (res) ->
    username = res.message.user.name
    resourceName = res.match[1]
    resourceUser = robot.brain.get('resource-' + resourceName)

    if resourceUser == null
      res.reply " returned " + resourceName
    else if resourceUser is username
      robot.brain.remove('resource-' + resourceName)
      res.reply " returned " + resourceName
    else
      res.reply ", " + resourceName + " is checked out by " + resourceUser + "."
