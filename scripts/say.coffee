# Description:
#

sh = require 'execSync'
shellescape = require 'shell-escape'

class SayMessage
  constructor: (@user, @text) ->
    @context =
      if @isAsciiMessage() then new EnglishContext else new JapaneseContext

  isAsciiMessage: () =>
    code = sh.run "echo #{shellescape [@text]}" +
                  " | nkf -g | xargs -I {} test {} = ASCII"
    return if code == 0 then true else false

  say: () =>
    sh.run "say -v #{shellescape [@context.getVoice()]}" +
           " #{shellescape [@getSayText()]}"

  outputLog: () =>
    console.log @getSayText(true)

  getSayText: (isRaw) =>
    text = if isRaw then @text else @context.replace(@text)
    return "@#{@user}, #{text}"

class LanguageContext
  replace: (text)->
    return @cutUrl text

  cutUrl: (text) ->
    return text
            .replace(/http[s]*:\/\/.+\s*(.*)$/g, '$1')

  getVoice: () ->
    return "Alex"

class JapaneseContext extends LanguageContext
  replace: (text) ->
    return super(text)
            .replace(/^RT\s|\sRT\s/, "リツイート, ")
            .replace(/#/, "シャープ, ")

  getVoice: () ->
    return process.env.SAY_HUBOT_JAPANESE_VOICE ? "Otoya"

class EnglishContext extends LanguageContext
  replace: (text) ->
    return super(text)
            .replace(/^RT\s|\sRT\s/, "retweet, ")
            .replace(/#/, "sharp, ")

  getVoice: () ->
    return process.env.SAY_HUBOT_ENGLISH_VOICE ? "Alex"

module.exports = (robot) ->
  robot.hear /^[^\s].*$/i, (msg) ->
    user = msg.envelope.message.user.name
    text = msg.envelope.message.text

    sm = new SayMessage user, text
    sm.outputLog()
    sm.say()
