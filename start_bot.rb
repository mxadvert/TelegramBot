require_relative './helpers'
require_relative './message_answer'
require_relative './inline_answer'

require 'telegram/bot'
require 'unicode'
require 'logger'

include Helpers
include MessageAnswer
include InlineAnswer

module RandomStupidNameBot

  def self.run
    token = '143189706:AAEXwSs96fpAuifImBg8NwsIdJoX56eD76k'
    logger = Logger.new('logs.log')

    Telegram::Bot::Client.run(token, logger: logger) do |bot|
      @dictionary = Dictionary.new.dictionary
      bot.listen do |message|
        begin
        puts bot.logger.info(message.inspect)
          case message
          when Telegram::Bot::Types::InlineQuery
            answer_to_inline(message, bot)
          when Telegram::Bot::Types::Message
            answer_to_message(message, bot)
          end
        rescue => e
          bot.logger.error(e)
        end
      end
    end
  end
end
