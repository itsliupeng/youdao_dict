require 'net/http'
require 'json'
require 'colorize'

module YoudaoDict

  def translate
    url = "http://fanyi.youdao.com/openapi.do?keyfrom=#{YoudaoDict.key_from}&key=#{YoudaoDict.key}&type=data&doctype=json&version=1.1&q=" + word  # must define attr_accessor :word in the included class
    res = Net::HTTP.get_response URI url
    if res.code == "200"
      @data = JSON.parse(res.body)
      parse_data
    else
      raise "cannot touch the youdao server..."
    end
  end

  private
  def parse_data
    case @data["errorCode"]
    when 0
      print_data
    when 20
      puts "要翻译的文本过长"
    when 30
      puts "无法进行有效的翻译"
    when 40
      puts "不支持的语言类型"
    when 50
      puts "无效的API key"
    when 60
      puts "无词典结果，仅在获取词典结果生效"
    else
      puts "不能释义的 errorCode"
    end
  end

  def print_data
    basic = @data["basic"]
    web = @data["web"]
    content = ""
    content <<  "/#{basic["phonetic"]}/  uk: /#{basic["uk-phonetic"]}/  us: /#{basic["us-phonetic"]}/\n".red if basic
    content << "翻译:\t#{@data["translation"].join(" | ")}\n".yellow if @data["translation"]
    content <<  "词典:\t#{basic["explains"].join("\n\t")}\n".blue if basic
    content << "网义:"
    web.each {|e|
      content << "\t#{e["key"]}: #{e["value"].join(" | ")}\n"
    } if web

    content
  end
end


