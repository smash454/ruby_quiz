require_relative 'Keystream'
class Encrypt
  @input = ''
  @encrypted = ''
  @keystream = ''
  @decrypted = ''
  attr_accessor :encrypted, :keystream, :decrypted
  
  def initialize (raw)
    @input = raw
  end
  
  def encode
    set_up
    @encrypted = convert_to_letters(add_num_array)
    @input = ''
    
  end
  
  def decode
    set_up
    @decrypted = convert_to_letters(sub_num_array)
  end
  
  def set_up
    @keystream = (Keystream.new(format_input.length)).keystream
    @input = convert_to_numbers(@input)
    @keystream = convert_to_numbers(@keystream)
  end
  
  def format_input
  
    @input = @input.upcase.gsub(/[^A-Z]/, '')
    len = @input.length
    off_by = len % 5
    buff = 0
    if off_by != 0
      buff = 5 - off_by
    end
    
    @input = @input.ljust(len + buff, "X")
    
    
  end
  
  def convert_to_numbers(input)
    number = []
    input.each_char {|c| c == ' ' ? number << c : number << c.ord % 64}
    number
  end
  
  def add_num_array
    @input.zip(@keystream).map do |x,y|
      if x == ' '
        x
      elsif x + y > 26
        x + y - 26
      else
        x + y
      end
    end
  end
  
  def sub_num_array
    @input.zip(@keystream).map do |x, y|
      if x == ' '
        x
      elsif x <= y
        x + 26 - y
      else
        x - y
      end
      
    end
  end
  
  def convert_to_letters(input)
    s = input.map {|n| n == ' ' ? n : ((n + 64).chr) }
    s = s.join
    s.scan(/.{5}/).join(' ')
  end
end

