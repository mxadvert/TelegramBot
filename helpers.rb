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
    data = JSON.parse(URI.parse(vk_source.sample).read)
    return nil if data.nil?
    imgs = get_photo_from_response(data)
    img_big = imgs['src_big']
    img = imgs['src']
		open('image.jpg', 'wb') do |file|
      file << open(img_big).read
    end
    {img_big: img_big, thumb_img: img}
  end

  def vk_source
    %w(
    https://api.vk.com/method/wall.get?domain=emoboys&count=100&offset=10
    )
  end

  def get_photo_from_response(data)
    att_number = Random.new.rand(1..99)
    data = data['response']
    if data[att_number].has_key?('attachment') && data[att_number]['attachment'].has_key?('photo')
      data[att_number]['attachment']['photo']
    else
      get_photo_from_response(data)
    end
  end
end
