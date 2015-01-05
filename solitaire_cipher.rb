
puts "Enter the word or phrase to encode"
raw = "Test phrase hello e"

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
  input.each_char {|c| number << c.ord % 64 unless c == ' '}
  number
end
