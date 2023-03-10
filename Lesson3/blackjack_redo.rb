# =begin
# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.
# =end

# require "pry"

# FULL_SET_OF_CARDS = [
#   ["H", "A"], ["H", "K"], ["H", "Q"], ["H", "J"], ["H", "10"], ["H", "9"], ["H", "8"], ["H", "7"], 
#   ["H", "6"], ["H", "5"], ["H", "4"], ["H", "3"], ["H", "2"], ["D", "A"], ["D", "K"], ["D", "Q"],
#   ["D", "J"], ["D", "10"], ["D", "9"], ["D", "8"], ["D", "7"], ["D", "6"], ["D", "5"], ["D", "4"], 
#   ["D", "3"], ["D", "2"], ["S", "A"], ["S", "K"], ["S", "Q"], ["S", "J"], ["S", "10"], ["S", "9"],
#   ["S", "8"], ["S", "7"], ["S", "6"], ["S", "5"], ["S", "4"], ["S", "3"], ["S", "2"], ["C", "A"], 
#   ["C", "K"], ["C", "Q"], ["C", "J"], ["C", "10"], ["C", "9"], ["C", "8"], ["C", "7"], ["C", "6"], 
#   ["C", "5"], ["C", "4"], ["C", "3"], ["C", "2"]
# ]
# FACE_CARDS = ["K", "Q", "J"]
# ACE = "A"
# deck = FULL_SET_OF_CARDS.clone
# player_hand = []
# dealer_hand = []
# choice_counter = [0]
# hit_counter = [0]

# def prompt(txt)
#   puts ">> #{txt}"
# end

# def deal_cards!(dck, hand)
#   2.times do
#     drawn_card = dck.sample
#     p_hand << drawn_card
#     dck.delete(drawn_card)
#   end
# end    

# def player_choice!(player_hand, choice_count, hit_count, deck)
#   choice_count[0] += 1
#   prompt "You can hit or stay! Type hit to add a card to your hand and stay to stand pat."
#   answer = gets.chomp
#   loop do 
#     if answer.downcase[0] == "h"
#       hit!(player_hand, hit_count, deck)
#       break
#     else
#       break
#     end
#   end
# end
  
# def hit!(hand, hit_count, dck)
#   hit_count[0] += 1
#   drawn_card = dck.sample
#   hand << drawn_card
#   dck.delete(drawn_card)
# end

# def extract_card_values(hand)
#   values = hand.map do |card|
#             card[1]
#            end
# end   

# def card_values_to_integers(hand)
#   values = extract_card_values(hand)
#   values.map! do |value|
#     if value.to_i > 0
#       value.to_i
#     elsif FACE_CARDS.include?(value)
#       10
#     elsif value == ACE
#       11
#     end
#   end
#   correct_ace_values!(values)
#   values
# end

# def correct_ace_values!(value_array)
#   number_of_aces = value_array.count(11)
#   loop do 
#     if value_array.sum > 21
#       break if number_of_aces == 0
#       number_of_aces -= 1
#       ace_index = value_array.find_index(11)
#       value_array[ace_index] = 1
#     else
#       break
#     end
#   end
# end

# def total_hand_value(hand)
#   card_values_to_integers(hand).sum
# end

# def busted?(hand)
#   total_hand_value(hand) > 21 ? true : false
# end

# def no_hit?(choice_count, hit_count)
#   choice_count[0] > hit_count[0]
# end

# def display_hands(player_h, dealer_h)
#   prompt "PLAYER HAND"
#   p player_h
#   prompt "DEALER HAND"
#   p dealer_h
# end

# def dealer_win?(dealer_hnd, player_hnd)
#   total_hand_value(dealer_hnd) > total_hand_value(player_hnd)
# end

# def dealer_win_output
#   prompt "THE DEALER WINS."
# end

# def player_win_output
#   prompt "YOU WIN"
# end

# def play_again?
#   prompt "Play again? (type yes to play again or anything else to quit)"
#   answer = gets.chomp
# end

# system "clear"
# loop do 
#   deal_cards!(deck, player_hand)
#   deal_cards!(deck, dealer_hand)
#   loop do
#     display_hands(player_hand, dealer_hand)
#     player_choice!(player_hand, choice_counter, hit_counter, deck)
#     if busted?(player_hand)
#       dealer_win
#       break
#     end
#     break if no_hit?(choice_counter, hit_counter)
#   end
#   loop do
#     if total_hand_value(dealer_hand) < 17
#     hit!(dealer_hand, hit_counter, deck)
#     if busted?(dealer_hand)
#       player_win_output
#       break
#     end
#     display_hands(player_hand, dealer_hand)
#     if dealer_win?(player_hand, dealer_hand)
#       dealer_win_output
#       break
#     end
#   end
#   answer = play_again?
#   break if answer.downcase[0] != "y"
# end

# prompt "OK COOL THANKS FOR PLAYING THEN HAVE A GOOD ONE"