
puts "Enter the word or phrase to encode"
raw = "Test phrase hello e"
keystream = "DWJXH YRFDG TMSHP UURXJ"

formatted_input = format_input(raw)

def format_input(raw)

  formatted = raw.upcase.gsub(/[^A-Z]/, '')
  off_by = formatted.length % 5
  buff = 0
  if off_by != 0
    buff = 5 - off_by
  end
  
  formatted = formatted.ljust(formatted.length + buff, "X")
  
  formatted.scan(/.{5}/).join(' ')
  
end

def convert_to_numbers(input)
  number = []
  input.each_char {|c| c == ' ' ? number << c : number << c.ord % 64}
  number
end

def add_num_array(msg, keystream)
  msg.zip(keystream).map do |x,y|
    if x == ' '
      x
    elsif x + y > 26
      x + y - 26
    else
      x + y
    end
  end
end

def convert_to_letters(input)
  s = input.map {|n| n == ' ' ? n : ((n + 64).chr) }
  s.join
end