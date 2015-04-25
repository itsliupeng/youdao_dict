module YoudaoDict
  def store
    print "\nStore #{@word} to dictionary? Yy\t".red

    begin
      system("stty raw echo")
      input = STDIN.getc.chomp
    ensure
      system("stty -raw echo")
    end

    if input  =~ /y/i
      File.open(YoudaoDict.filename, 'a') do |f|
        f.write "#{@word}:"
        f.write "\t/#{@data["basic"]["phonetic"]}/" if @data["basic"] and @data["basic"]["phonetic"]
        f.write  "\t#{@data["translation"].join(" | ")}" if @data["translation"]
        # f.write  "\t #{@data["basic"]["explains"].join(" | ")}" if @data["basic"]["explains"]
        f.write "\t#{Time.now.to_s.split(" +").first}\n"
      end
    end
  end


  def stored?
    word_dict = []
    File.open(YoudaoDict.filename, "r") do |f|
      f.readlines.each do |e|
        word_dict << e.split(":", 2).first
      end
    end

    if word_dict.include? @word
      true
    else
      false
    end
  end
end
