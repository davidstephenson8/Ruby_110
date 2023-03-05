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

FACE_CARDS = ["K", "Q", "J"]

ACE = "A"

deck = FULL_SET_OF_CARDS.clone

player_hand = []

dealer_hand = []

def deal_cards!(dck, p_hand, d_hand)
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

def pretty_suits(hand)
  hand.map do |card|
    if card[0] == "H"
      ["♥", card[1]]
    elsif card[0] == "C"
      ["♣", card[1]]
    elsif card[0] == "D"
      ["⬩", card[1]]
    else
      ["♠", card[1]]
    end
  end
end

def display_cards(hand)
  hand = pretty_suits(hand) 
  suit_1 = hand[0][0]
  value_1 = hand[0][1]
  suit_2 = hand[1][0]
  value_2 = hand[1][1]
  puts "┌---------┐   ┌---------┐"
  puts "| #{suit_1}       |   | #{suit_2}       |"
  puts "|         |   |         |"
  puts "|    " + "#{value_1}".ljust(2) + "   |   |    " + "#{value_2}".ljust(2)+ "   |"
  puts "|         |   |         |"
  puts "|       #{suit_1} |   |       #{suit_2} |"
  puts "└---------┘   └---------┘"
end

def generate_card(card)
  suit = card[0]
  value = card[1]
  card = ["┌---------┐   ",
          "| #{suit}       |",
          "|         |", 
          "|    " + "#{value}".ljust(2) + "   |   "
          "|         |   "
          "|       #{suit} |   ",
          "└---------┘   "
          ]
  card
end

def display_hands(p_hand, d_hand)
  prompt "PLAYER HAND"
  display_cards(p_hand)
  prompt "DEALER HAND"
  display_cards(d_hand)
end

def player_choice!(dck, p_hand)
  prompt "Do you want to hit or stay?"
  answer = gets.chomp
  if answer.downcase[0] == 'h'
    p_hand = hit!(dck, p_hand)
  elsif answer.downcase[0] == 's'
    return
  else
    prompt "sorry, I didn't get that" 
  end
end

def hit!(dck, hand)
  dealt_card = dck.sample
  hand << dealt_card
  dck.delete dealt_card
  hand
end

def cards_to_values(p_hand)
  card_values = []
  p_hand.each do |card|
    card_values << card[1]
  end
  card_values.map! do |value|
    if FACE_CARDS.include?(value)
      10
    elsif value == "A"
      value
    else
      value.to_i
    end
  end
  # evaluate_aces!(card_values)
end

# this method is going to evaluate the arrays after all of the other cards have been 
# converted to their point values in #cards_to_values



def evaluate_aces!(card_values)
  p card_values.select do |value|
    value.to_i > 0 # because the string "A" evaluates to 0 and all of the other values evaluate to positive integers
  end
  p other_cards
  if other_cards.sum < 11
    card_values.map! do value
      if value == "A"
        11
      else
        value
      end
    end
  end
  if other_cards.sum >= 11
    card_values.map! do value
      if value == "A"
        1
      else
        value
      end
    end
  end
end

=begin
how to evaluate if an ace is equal to 1 or 11
evaluate all of the other cards in the hand
if equal to 10 or less ace is 11
if 11 or more ace is 1
=end

def evaluate_hand(p_hand)
  values = cards_to_values(p_hand).sum
  if values == 21
    prompt "BLACKJACK"
  elsif values > 21
    prompt "BUSTED"
  else
    prompt "NICE"
  end
end

system "clear"
loop do
  deal_cards!(deck, player_hand, dealer_hand)
  loop do
    display_hands(player_hand, dealer_hand)
    loop do
      player_choice!(deck, player_hand)
      evaluate_hand(player_hand)
      break
    end
    p player_hand
    break
  end
  break
end
