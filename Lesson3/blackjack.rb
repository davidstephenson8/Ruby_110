=begin
1. Initialize deck
2. Deal cards to player and dealer
3. Player turn: hit or stay
  - repeat until bust or "stay"
4. If player bust, dealer wins.
5. Dealer turn: hit or stay
  - repeat until total >= 17
6. If dealer bust, player wins.
7. Compare cards and declare winner.
=end

FULL_SET_OF_CARDS = [
  ["H", "A"], ["H", "K"], ["H", "Q"], ["H", "J"], ["H", "10"], ["H", "9"], ["H", "8"], ["H", "7"], 
  ["H", "6"], ["H", "5"], ["H", "4"], ["H", "3"], ["H", "2"], ["D", "A"], ["D", "K"], ["D", "Q"],
  ["D", "J"], ["D", "10"], ["D", "9"], ["D", "8"], ["D", "7"], ["D", "6"], ["D", "5"], ["D", "4"], 
  ["D", "3"], ["D", "2"], ["S", "A"], ["S", "K"], ["S", "Q"], ["S", "J"], ["S", "10"], ["S", "9"],
  ["S", "8"], ["S", "7"], ["S", "6"], ["S", "5"], ["S", "4"], ["S", "3"], ["S", "2"], ["C", "A"], 
  ["C", "K"], ["C", "Q"], ["C", "J"], ["C", "10"], ["C", "9"], ["C", "8"], ["C", "7"], ["C", "6"], 
  ["C", "5"], ["C", "4"], ["C", "3"], ["C", "2"]
]

deck = FULL_SET_OF_CARDS.clone

player_hand = []

dealer_hand = []

def deal_cards(dck, p_hand, d_hand)
  2.times do |_|
    dealt_card = dck.sample
    p_hand << dealt_card
    dck.delete(dealt_card)
  end
  2.times do |_|
    dealt_card = dck.sample
    d_hand << dealt_card
    dck.delete(dealt_card)
  end
end

def prompt(txt)
  puts ">> #{txt}"
end
  

def player_choice(dck, p_hand)
  prompt "Do you want to hit or stay?"
  answer = gets.chomp
  if answer.downcase[0] == 'h'
    p_hand = player_hit(dck, p_hand)
    p p_hand
  elsif answer.downcase[0] == 's'
    return p_hand 
  end
end

def player_hit(dck, p_hand)
  dealt_card = dck.sample
  p_hand << dealt_card
  dck.delete dealt_card
  p_hand
end


loop do
  deal_cards(deck, player_hand, dealer_hand)
  loop do
    p player_hand
    player_choice(deck, player_hand)
    break
  end
  break
end


