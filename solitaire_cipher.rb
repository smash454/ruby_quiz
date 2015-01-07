
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

def sub_num_array(code, keystream)
  code.zip(keystream).map do |x, y|
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
  s.join
end

def build_deck
  base_deck =  {"Ace of " => 1, "Two of " => 2, 
                "Three of " => 3, "Four of " => 4,
                "Five of " => 5, "Six of " => 6,
                "Seven of " => 7, "Eight of " => 8,
                "Nine of " => 9, "Ten of " => 10,
                "Jack of " => 11, "Queen of " => 12,
                "King of " => 13}
  clubs = {}
  base_deck.each {|k, v| clubs[k + "Clubs"] = v}
  diamonds = {}
  base_deck.each {|k, v| diamonds[k + "Diamonds"] = v + 13}
  hearts = {}
  base_deck.each {|k, v| hearts[k + "Hearts"] = v + 26}
  spades = {}
  base_deck.each {|k, v| spades[k + "Spades"] = v + 39}
  jokers = {"Joker_A" => "A", "Joker_B" => "B"}
  
  clubs.merge(diamonds).merge(hearts).merge(spades).merge(jokers)
end