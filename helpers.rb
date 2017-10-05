require './Predictions/prediction'
require './Mems/mem'
require './Dictionary/dictionary'

module Helpers
  def response_with
    yield
  rescue Telegram::Bot::Exceptions::ResponseError => e
    puts e
  end

  def keyboard
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(
      keyboard: [%w[Предсказание], %w[Мем]],
      one_time_keyboard: true
    )
  end

  def prediction(user)
    "Итак, #{user}\n" + Prediction.call
  end

  def catch_mem
    Mem.catch_mem
  end
end
