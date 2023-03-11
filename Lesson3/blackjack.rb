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

require "pry"

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

def prompt(txt)
  puts ">> #{txt}"
end

def deal_cards!(p_hand, d_hand, dck)
  2.times do
    drawn_card = dck.sample
    p_hand << drawn_card
    dck.delete(drawn_card)
  end
  2.times do
    drawn_card = dck.sample
    d_hand << drawn_card
    dck.delete(drawn_card)
  end
end    
  
def hit!(hand, dck)
  
  drawn_card = dck.sample
  hand << drawn_card
  dck.delete(drawn_card)
end

def extract_card_values(hand)
  values = hand.map do |card|
            card[1]
           end
end   

def card_values_to_integers(hand)
  values = extract_card_values(hand)
  values.map! do |value|
    if value.to_i > 0
      value.to_i
    elsif FACE_CARDS.include?(value)
      10
    elsif value == ACE
      11
    end
  end
  correct_ace_values!(values)
  values
end

def correct_ace_values!(value_array)
  number_of_aces = value_array.count(11)
  loop do 
    if value_array.sum > 21
      break if number_of_aces == 0
      number_of_aces -= 1
      ace_index = value_array.find_index(11)
      value_array[ace_index] = 1
    else
      break
    end
  end
end

def total_hand_value(hand)
  card_values_to_integers(hand).sum
end

def busted?(hand)
  total_hand_value(hand) > 21 ? true : false
end

def suit_swap(card)
  case card[0]
  when "C"
    "♣"
  when "H"
    "♥"
  when "S"
    "♠"
  when "D"
    "⬩"
  end
end

def generate_card(card)
  value = card[1]
  suit = suit_swap(card) 
  card_template = ["┌---------┐   ",
                   "| S       |   ",
                   "|         |   ", 
                   "|   _9    |   ",
                   "|         |   ",
                   "|       S |   ",
                   "└---------┘   "
                   ]
  pretty_card = card_template.map do |line|
                chars = line.chars
                chars.map! do |char|
                  if char == "S"
                    suit
                  elsif
                    char == "_"
                    if value == "10"
                      "1"
                    else
                      " "
                    end
                  elsif char == "9"
                    if value == "10"
                      "0"
                    else
                      value
                    end
                  else 
                    char
                  end  
                end
                chars.join
              end
  pretty_card
end

def generate_pretty_hand(hand)
  pretty_card_hand = hand.map do |card|
                        generate_card(card)
                      end
  pretty_card_hand.each do |pretty_card|
    if pretty_card == pretty_card_hand[0]
      next
    else
      for n in 0..6 do
        pretty_card_hand[0][n] << pretty_card[n]
      end
    end
  end
  pretty_card_hand = pretty_card_hand[0]
end

def display_hand(hand)
  hand.each do |line|
    puts line
  end
end

def display_hands(player_h, dealer_h)
  player_total = total_hand_value(player_h)
  dealer_total = total_hand_value(dealer_h)
  prompt "PLAYER HAND"
  player_h = generate_pretty_hand(player_h)
  display_hand(player_h)
  prompt "player total: #{player_total}"
  prompt "DEALER HAND"
  dealer_h = generate_pretty_hand(dealer_h)
  display_hand(dealer_h)
  prompt "dealer total: #{dealer_total}"
end

def check_for_win(player_hnd, dealer_hnd)
  if total_hand_value(dealer_hnd) > total_hand_value(player_hnd)
    "dealer"
  elsif total_hand_value(player_hnd) > total_hand_value(dealer_hnd)
    "player"
  else
    "tie"
  end
end

def win_output(winner)
  if winner == "dealer"
    prompt "THE DEALER WON, SORRY!"
  elsif winner == "player"
    prompt "THE PLAYER WON"
  else
    prompt "It's a tie?!"
  end
end

def playagain!(player_hnd, dealer_hnd)
  player_hnd.clear
  dealer_hnd.clear
  prompt "Play again? (type yes to play again or anything else to quit)"
  answer = gets.chomp
  answer
end

loop do
  system "clear"
  deal_cards!(player_hand, dealer_hand, deck)
  loop do 
    display_hands(player_hand, dealer_hand)
    prompt "Do you want to hit or stay?"
    action = gets.chomp
    if action.downcase[0] == "h"
      hit!(player_hand, deck)
    elsif action.downcase[0] != "h"
      break
    else
      prompt "sorry, didn't understand that" 
    end
    if busted?(player_hand)
      display_hands(player_hand, dealer_hand)
      prompt "You busted. Lol."
      win_output("dealer")
      break
    end
  end
  loop do
    break if busted?(player_hand)
    if total_hand_value(dealer_hand) < 17
      hit!(dealer_hand, deck)
      display_hands(player_hand, dealer_hand)
      if busted?(dealer_hand)
        prompt "The dealer busted!"
        win_output("player")
        break
      end
    else
      display_hands(player_hand, dealer_hand)
      winner = check_for_win(player_hand, dealer_hand)
      win_output(winner)
      break
    end
  end
  answer = playagain!(player_hand, dealer_hand)
  break if answer.downcase[0] != "y"
end

prompt "OK COOL THANKS FOR PLAYING THEN HAVE A GOOD ONE"
