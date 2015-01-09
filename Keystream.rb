require_relative 'Deck'
class Keystream
  @deck = []
  @keystream = ''
  @msg_len = 0
  attr_accessor :keystream
  
  def initialize (length)
    @deck = Deck.new
    @msg_len = length
    @keystream = String.new
    generate_keystream
  end
  
  def find_output_letter
    idx = @deck.get_card(0)
    
    idx.is_a?(Fixnum) ? idx : idx = 53
    
    value = @deck.get_card(idx)
    if value.is_a? Fixnum
      if value > 26
        value = value - 26
      end
      value += 64
      return value.chr
    else
      @deck.process
      find_output_letter
    end
    
  end
  
  def generate_keystream
    l = ''
    (@msg_len).times do
      @deck.process
      l = find_output_letter
      @keystream << l unless l.nil?
    end
  end
  
end