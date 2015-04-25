require File.expand_path '../../lib/youdao_dict', __FILE__


a = Word.new ARGV.join(" ")
puts a.translate

# binding.pry

a.store  if not a.stored?

