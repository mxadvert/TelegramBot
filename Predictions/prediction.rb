require_relative './dictionary'

module Prediction
  class << self
    def call
      [date, to, what, happened].join(' ')
    end

    private

    def date
      Prediction::Dictionary.date.sample
    end

    def to
      Prediction::Dictionary.to.sample
    end

    def what
      Prediction::Dictionary.what.sample
    end

    def happened
      Prediction::Dictionary.happened.sample
    end
  end
end

puts Prediction.call
