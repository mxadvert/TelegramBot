require './helpers'
require './message_answer'
require './inline_answer'

require 'telegram/bot'
require 'unicode'
require 'open-uri'
require 'net/http'
require 'json'
require 'logger'

include Helpers
include MessageAnswer
include InlineAnswer

token = '143189706:AAEXwSs96fpAuifImBg8NwsIdJoX56eD76k'

Telegram::Bot::Client.run(token, logger: Logger.new($stdout)) do |bot|
  @dictionary = Dictionary.new.dictionary
  bot.listen do |message|
    puts message.inspect
    case message
    when Telegram::Bot::Types::InlineQuery
      answer_to_inline(message, bot)
    when Telegram::Bot::Types::Message
      answer_to_message(message, bot)
    end
  end
end
