# Description:
#   Hubot responds any thank message politely. Phrases from:
#   http://www.macmillandictionary.com/thesaurus-category/british/Ways-of-accepting-someone-s-thanks
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot thank[s] [you] - Hubot accepts your thanks
#   thanks hubot - Hubot accepts your thanks
#
# Author:
#   github.com/delucas
#

response = [
  "watch your language!",
  "i'm not going to respond to that",
  "...",
  "what is your problem?",
  "please do not use those words",
  "I'm feeling offended",
  "plesae be nice to me, I do have feelings you know.",
  "gosh...",
  "Looking for troubles?",
  "are you talking about yourself?",
  "I think you need some profesional help",
  "do not make me angry or I will unleash my power..."
]

module.exports = (robot) ->
  robot.respond /(.*)shit(.*)|(.*)crap(.*)|(.*)ass(.*)|(.*)loser(.*)/i, (msg) ->
    msg.send msg.random response
  language = new RegExp "fuck you #{robot.name}", "i"
  robot.hear language, (msg) ->
    msg.send msg.random response
