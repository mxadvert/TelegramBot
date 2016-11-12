module InlineAnswer
  def answer_to_inline(message, bot)
    puts message.query
    puts message.inspect
    case message.query
    when '/start'
      text =  "Я #{@dictionary[:property_words].sample} #{@dictionary[:who_words].sample} запустил бота"
      response_with do
        bot.api.answer_inline_query(inline_query_id: message.id, results: make_text_answer(text, 'нууу привет'))
      end

    when '/prediction'
      response_with do
        bot.api.answer_inline_query(inline_query_id: message.id,
          results: make_text_answer(prediction(message.from.first_name), 'предсказание? да?'))
      end

    when '/mem' || '/memas'
      photo_url = catch_mem
      response_with do
        bot.api.answer_inline_query(inline_query_id: message.id, results: make_photo_answer(photo_url, 'хочешь мем?'))
      end
    end

  end

  private
  def  make_text_answer(text, title)
    [Telegram::Bot::Types::InlineQueryResultArticle.new(
      id: '10',
      title: title,
      input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(message_text: text)
    )]
  end

  def make_photo_answer(photo_url, title)
    [1..5].map do |id|
    Telegram::Bot::Types::InlineQueryResultPhoto.new(
      type: 'photo',
      id: id,
      title: title,
      photo_url: photo_url[:img_big],
      thumb_url: photo_url[:thumb_img]
    )
  end
end
