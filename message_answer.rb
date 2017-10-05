module MessageAnswer
  def answer_to_message(message, bot)
    unless message.text.nil?
      if @dictionary[:hello_words].include? Unicode::downcase(message.text)
        text = "Воспользуйся клавиатурой #{@dictionary[:property_words].sample} #{@dictionary[:who_words].sample}"
        keyboard = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [%w(Привет Предсказание), %w(Мем Ахах)], one_time_keyboard: true)
        response_with do
          bot.api.sendMessage(chat_id: message.chat.id,text: text, reply_markup: keyboard)
        end

      elsif @dictionary[:prediction_words].any?{ |word| message.text.split.map{|a| Unicode::downcase a}.include? word}
        response_with do
          bot.api.sendMessage(chat_id: message.chat.id, text: prediction(message.from.first_name))
        end

      elsif @dictionary[:mem_words].any?{ |word| message.text.split.map{|a| Unicode::downcase a}.include? word}
        mem = catch_mem
        if mem.nil?
          response_with do
              bot.api.sendMessage(chat_id: message.chat.id,text: 'не получилось скачать мем(((')
          end
        else
          response_with do
            bot.api.send_photo(chat_id: message.chat.id, photo: mem)
          end
        end

      elsif @dictionary[:laugh_words].any?{ |word| message.text.split.map{|a| Unicode::downcase a}.include? word}
        response_with do
          bot.api.send_message(chat_id: message.chat.id, text: 'весело тебе, я погляжу?')
          sleep 1
          bot.api.send_sticker(chat_id: message.chat.id, sticker: 'BQADAgAD1QIAAiSGFAX8Dy8SftmcDgI')
          sleep 0.5
          bot.api.send_sticker(chat_id: message.chat.id, sticker: 'BQADAgAD1wIAAiSGFAX9JRT_wXGHngI')
        end

      else
        text = "Воспользуйся клавиатурой #{@dictionary[:property_words].sample} #{@dictionary[:who_words].sample}"
        keyboard = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [%w(Привет Предсказание), %w(Мем Ахах)], one_time_keyboard: true)
        response_with do
          bot.api.send_message(chat_id: message.chat.id, text: text, reply_markup: keyboard)
        end
      end
    end
  end
end
