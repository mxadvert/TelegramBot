module Helpers

  def response_with
    begin
      yield
    rescue Telegram::Bot::Exceptions::ResponseError => e
      puts e
    end
  end

  class Dictionary
    attr_accessor :dictionary
    def initialize
      @dictionary = {}
      Dir.foreach('./Dictionary') do |item|
        next if item == '.' or item == '..'
        @dictionary[item.to_sym] =  File.readlines("./Dictionary/#{item}").map(&:split).flatten.map{|e| e.gsub('_',' ')}
      end
    end
  end

  def prediction user
    date = %w{сегодня завтра на\ неделе в\ выходные в\ субботу вечером утром ночью}
    to = %w{тебя твою\ тян твоего\ кореша твою\ мамку твоих\ друзей твоих\ родственников твою\ душу}
    what = %w{ждет поджидает ожидает поприветствует выпадет}
    happened = %w{удача смерть богатство перепихон смехуечки зоёто скандал холод нищета наркотики говно школка жиза}
    "Итак, #{user}\n" + date.sample + " " + to.sample + " "  + what.sample + " " + happened.sample
  end

  def catch_mem
    data = JSON.parse(URI.parse("https://api.vk.com/method/wall.get?domain=emoboys&count=15&offset=10").read)
    img_big = data['response'][Random.new.rand(1..14)]['attachment']['photo']['src_big']
    img = data['response'][Random.new.rand(1..14)]['attachment']['photo']['src']
		open('image.jpg', 'wb') do |file|
      file << open(img_big).read
    end
    {img_big: img_big, thumb_img: img}
  end
end
