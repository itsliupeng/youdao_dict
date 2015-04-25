require 'active_support/all'

module YoudaoDict
  class << self
    def words_of(date)
      date_word = date_word_realtion
      case date
      when /today/
        time = Time.now.to_s.split.first
        date_word[time]
      when /yesterday/
        time = Date.yesterday.to_s
        date_word[time]
      # to_do
      # when /week/
      #   time = 1.week.ago.to_s
      #   date_word[time]
      # when /month/
      #   time = 1.month.ago.to_s
      #   date_word[time]
      else
        date_word.values.flatten
      end
    end

    def date_word_realtion
      date_word = {}
      File.open(YoudaoDict.filename, 'r') do |f|
        f.readlines.each do |e|
          word = e.split(":", 2).first
          date = e.split[-2]
          date_word[date] = [] if not date_word.has_key? date
          date_word[date] << word
        end
      end
      date_word
    end
  end
end
