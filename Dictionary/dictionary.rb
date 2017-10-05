class Dictionary
    attr_accessor :dictionary

    def initialize
      @dictionary = {}
      Dir.foreach(words_path) do |item|
        next if item == '.' ||  item == '..'
        file_path = File.join(File.dirname(__FILE__), "./Words/#{item}")
        @dictionary[item.to_sym] =  file_to_array(file_path)
      end
    end

    private 

    def file_to_array(file_name)
      File.readlines(file_name).map(&:split).flatten.map{|e| e.gsub('_',' ')}
    end

    def words_path
      File.join(File.dirname(__FILE__), './Words')
    end
end
