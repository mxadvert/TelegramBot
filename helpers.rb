require './Predictions/prediction'
require './Mems/mem'
require './Dictionary/dictionary'

module Helpers
  def response_with
    begin
      yield
    rescue Telegram::Bot::Exceptions::ResponseError => e
      puts e
    end
  end

  def prediction user
    "Итак, #{user}\n" + Prediction.call
  end

  def catch_mem
    Mem.catch_mem
  end
end
