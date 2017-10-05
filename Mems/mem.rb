require 'pry'
require 'json'
require 'open-uri'

module Mem
  MEM_SOURCES = File.read(
    File.join(File.dirname(__FILE__), './mem_sources')
  ).split(' ')

  ACCESS_TOKEN =
    '48674adb48674adb48674adb10483794454486748674adb11d7b48d3e8492ac8148c430'.freeze

  class << self
    def catch_mem
      imgs = get_photo_json
      imgs['src_big']
    end

    def catch_mem_with_sizes
      imgs = get_photo_json
      { img_big: imgs['src_big'], thumb_img: imgs['src'] }
    end

    private

    def get_photo_json
      data = JSON.parse(URI.parse(vk_sources.sample).read)
      Raise 'Error, no response from VK' if data.nil?
      get_photo_from_response(data)
    end

    def vk_sources
      MEM_SOURCES.map { |domain| vk_source(domain) }
    end

    def vk_source(domain)
      "https://api.vk.com/method/wall.get?domain=#{domain}&count=100&offset=10&access_token=#{ACCESS_TOKEN}"
    end

    def get_photo_from_response(data)
    begin
      data = data['response']
      data.shift # remove first element, some meta data from vk

      data = data.select { |d| d.dig('attachment', 'photo') }
      att_number = Random.new.rand(0..data.length - 1)
 
      data[att_number]['attachment']['photo']
    rescue => e
      binding.pry
    end
    end
  end
end
