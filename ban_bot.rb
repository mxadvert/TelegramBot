require 'telegram/bot'
require 'logger'
require 'pry'

token = '143189706:AAEXwSs96fpAuifImBg8NwsIdJoX56eD76k'

Telegram::Bot::Client.run(token, logger: Logger.new($stdout)) do |bot|
  bot.api.restrictChatMember(chat_id: -1001133594434, user_id: 138438351)
  bot.listen do |message|
  begin
    puts message.inspect
    chat = message&.chat&.id
    users = message&.new_chat_members&.map(&:id)
    users.map do |user|
      bot.api.restrictChatMember(chat_id: chat, user_id: user)
    end

  rescue  => e
    puts "ERROR #{e}"
    binding.pry
  end
  
  end
end
