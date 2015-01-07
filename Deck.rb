class Deck
  @deck = 0
  
  def initialize  
    @deck = build_deck2
  end
  
  def build_deck1
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
  
  def build_deck2
    (1..52).to_a << "A" << "B"
  end
  
  def move_card_down(card, spaces = 1)
    idx = @deck.index(card) + spaces
    if idx > 53
      idx = idx - 53
    end
    @deck.insert(idx, @deck.delete(card))
  end
  
  def move_card_up(card, spaces = 1)
    idx = @deck.index(card) - spaces
    if idx < 0
      idx = idx + 53
    end
    @deck.insert(idx, @deck.delete(card))
  end
  
  def slice_above(new_top)
    tp_idx = @deck.index(new_top)
    @deck.slice!(0, tp_idx)
  end
  
  def slice_below(new_bottom)
    btm_idx = @deck.index(new_bottom)
    @deck.slice!(btm_idx + 1, @deck.length-1)
  end
  
  def triple_slice(top, bottom)
    crds_above = slice_above(top)
    crds_below = slice_below(bottom)
    @deck.push(crds_above).unshift(crds_below).flatten!
  end
  
  def count_cut(total)
    @deck.push(@deck.slice!(0, total)).flatten!
  end
end