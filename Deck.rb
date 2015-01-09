class Deck
  @deck = []
  
  def initialize  
    @deck = default_deck
  end
  
  def get_card(idx)
    @deck[idx]
  end
  
  def get_deck
    @deck
  end
  
  def default_deck
    (1..52).to_a << "A" << "B"
  end
  
  def move_card_down(card, spaces)
    idx = @deck.index(card) + spaces
    if idx > 53
      idx = idx - 53
    end
    @deck.insert(idx, @deck.delete(card))
  end
  
  def move_card_up(card, spaces)
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
  
  def triple_cut(top, bottom)
    crds_above = slice_above(top)
    crds_below = slice_below(bottom)
    @deck.push(crds_above).unshift(crds_below).flatten!
  end
  
  def count_cut
    
    card = @deck.slice!(0, @deck[@deck.length - 1])
    @deck.insert(@deck.length - 1, card).flatten!
  end
  
  def process
      move_card_down("A", 1)
      move_card_down("B", 2)
      @deck.index("B") < @deck.index("A") ? triple_cut("B", "A") : triple_cut("A", "B")
      count_cut
  end
end