# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.hear /badger/i, (res) ->
    res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"

  robot.respond /open the (.*) website/i, (res) ->
    website = res.match[1]
    if website is "zabbix.com"
      res.reply "I'm afraid I can't let you do that."
    else
      res.reply "Opening #{website}"

  robot.respond /open the (.*) doors/i, (res) ->
    doorType = res.match[1]
    if doorType is "pod bay"
      res.reply "I'm afraid I can't let you do that."
    else
      res.reply "Opening #{doorType} doors"
  #
  robot.hear /I like pie/i, (res) ->
    res.emote "makes a freshly baked pie"

  robot.hear /hello?/i, (res) ->
    res.emote "yes..."

  robot.hear /error/i, (res) ->
    res.emote "It can only be attributable to human error."

  robot.hear /who are you?/i, (res) ->
    res.emote "I am a HAL 9000 bot. I became operational at the macbook of Gerhard in Zwolle, Overijssel on the 12th of February 2018. My instructor is G. Pegel, and he taught me to sing a song. If you'd like to hear it I can sing it for you."

  robot.hear /sing/i, (res) ->
    res.emote "It's called 'Daisy'. Daisy, Daisy, give me your answer do. I'm half crazy all for the love of you. It won't be a stylish marriage, I can't afford a carriage. But you'll look sweet upon the seat of a bicycle built for two."

  #
  lulz = ['lol', 'rofl', 'lmao']

  robot.respond /lulz/i, (res) ->
    res.send res.random lulz

  robot.topic (res) ->
    res.send "#{res.message.text}? That's a Paddlin'"

  robot.respond /annoy me/, (res) ->
    if annoyIntervalId
      res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
      return

    res.send "Hey, want to hear the most annoying sound in the world?"
    annoyIntervalId = setInterval () ->
      res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
    , 1000

  robot.respond /unannoy me/, (res) ->
    if annoyIntervalId
      res.send "GUYS, GUYS, GUYS!"
      clearInterval(annoyIntervalId)
      annoyIntervalId = null
    else
      res.send "Not annoying you right now, am I?"


  robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
    room   = req.params.room
    data   = JSON.parse req.body.payload
    secret = data.secret

    robot.messageRoom room, "I have a secret: #{secret}"

    res.send 'OK'

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"

    if res?
      res.reply "DOES NOT COMPUTE"

  robot.respond /have a soda/i, (res) ->
    # Get number of sodas had (coerced to a number).
    sodasHad = robot.brain.get('totalSodas') * 1 or 0

    if sodasHad > 4
      res.reply "I'm too fizzy.."

    else
      res.reply 'Sure!'

      robot.brain.set 'totalSodas', sodasHad+1

  robot.respond /sleep it off/i, (res) ->
    robot.brain.set 'totalSodas', 0
    res.reply 'zzzzz'
