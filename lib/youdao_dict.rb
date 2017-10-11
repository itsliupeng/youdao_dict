require_relative 'youdao_dict/version'
require_relative 'youdao_dict/translate'
require_relative 'youdao_dict/store'
require_relative 'youdao_dict/statistic'

require 'yaml'

module YoudaoDict
  class << self
    attr_reader :key, :key_from, :filename
    def included(base)
      @key  = base::KEY
      @key_from = base::KEY_FROM
      @filename = base::FILENAME
    end
  end

end


class Word
  attr_accessor :word

  FILENAME = File.expand_path "../../data/dict/#{Time.now.strftime("%Y%U")}", __FILE__
  CONFIG_FILE = File.expand_path '../../config/youdao_dict.yml', __FILE__

  config_data = YAML.load(File.read(CONFIG_FILE))
  KEY_FROM = config_data["key_from"]
  KEY = config_data["key"]

  include YoudaoDict

  def initialize(word)
    @word = word
  end
end
