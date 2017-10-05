module InlineAnswer
  require 'enumerator'
  def answer_to_inline(message, bot)
    case message.query
    when '/start'
      text = "Я #{@dictionary[:property_words].sample} #{@dictionary[:who_words].sample} запустил бота"
      response_with do
        bot.api.answer_inline_query(inline_query_id: message.id, results: make_text_answer(text, 'нууу привет', Helpers.keyboard))
      end

    when '/prediction'
      response_with do
        bot.api.answer_inline_query(inline_query_id: message.id,
                                    results: make_text_answer(prediction(message.from.first_name), 'предсказание? да?'))
      end

    when '/mem'
      photo_url = catch_mem
      response_with do
        bot.api.answer_inline_query(inline_query_id: message.id, results: make_photo_answer)
      end
    end
  end

  private

  def make_text_answer(text, title, keyboard = nil)
    [Telegram::Bot::Types::InlineQueryResultArticle.new(
      id: '10',
      title: title,
      input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(message_text: text),
      reply_markup: keyboard
    )]
  end

  def make_photo_answer
    memes = []
    5.times do
      memes << Mem.catch_mem_with_sizes
    end
    memes.map do |mem, _i|
      Telegram::Bot::Types::InlineQueryResultPhoto.new(
        type: 'photo',
        id: Random.new.rand(1..100_000),
        title: 'хочешь мем?',
        photo_url: mem[:img_big],
        thumb_url: mem[:thumb_img]
      )
    end
  end
end
