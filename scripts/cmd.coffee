# Description:
#   Runs a command on hubot
#   TOTAL VIOLATION of any and all security!
#
# Commands:
#   hubot cmd <command> - runs a command on hubot host

module.exports = (robot) ->
  robot.respond /CMD (.*)$/i, (msg) ->
    # console.log(msg)
    @exec = require('child_process').exec
    cmd = msg.match[1]
    msg.send "Running [#{cmd}]..."

    @exec cmd, (error, stdout, stderr) ->
      if error
        msg.send error
        msg.send stderr
      else
        msg.send stdout
