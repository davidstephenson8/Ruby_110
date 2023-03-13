require "pry"

FULL_SET_OF_CARDS = [
  ["H", "A"], ["H", "K"], ["H", "Q"], ["H", "J"], ["H", "10"], ["H", "9"],
  ["H", "8"], ["H", "7"], ["H", "6"], ["H", "5"], ["H", "4"], ["H", "3"],
  ["H", "2"], ["D", "A"], ["D", "K"], ["D", "Q"], ["D", "J"], ["D", "10"],
  ["D", "9"], ["D", "8"], ["D", "7"], ["D", "6"], ["D", "5"], ["D", "4"],
  ["D", "3"], ["D", "2"], ["S", "A"], ["S", "K"], ["S", "Q"], ["S", "J"],
  ["S", "10"], ["S", "9"], ["S", "8"], ["S", "7"], ["S", "6"], ["S", "5"],
  ["S", "4"], ["S", "3"], ["S", "2"], ["C", "A"], ["C", "K"], ["C", "Q"],
  ["C", "J"], ["C", "10"], ["C", "9"], ["C", "8"], ["C", "7"], ["C", "6"],
  ["C", "5"], ["C", "4"], ["C", "3"], ["C", "2"]
]
FACE_CARDS = ["K", "Q", "J"]
ACE = "A"
DEALER_THRESHHOLD = 17
GOAL_POINT_TOTAL = 21
GRAND_CHAMPION_COUNT = 5
deck = FULL_SET_OF_CARDS.clone
player_hand = []
dealer_hand = []
player_wins = [0]
dealer_wins = [0]
winner = nil

def prompt(txt)
  puts ">> #{txt}"
end

def player_education
  prompt "Blackjack is a game played between the player and a dealer."
  prompt "The objective of the game is to get closest to 21 points without"
  prompt "going over. The player goes first, and can choose to hit (add"
  prompt "another card to their hand) or stay (pass the play"
  prompt "to the dealer). The player can only see one of the dealer's cards"
  prompt "during their turn, so they play with incomplete information."
  prompt " "
  prompt "The dealer then attempts to get to 21, but will"
  prompt "stop at 17. Number cards are worth their value, so a 1 is worth"
  prompt " 1, 2 is worth 2 points, etc. Face cards are worth 10 points and"
  prompt "aces can be worth 1 point or 11 points depending on the other cards"
  prompt "in your hand. If an ace being valued at 11 and makes you go over 21,"
  prompt "it's instead evaluated as a 1."
  prompt " "
  prompt "Press enter to play blackjack! First one to 5 wins!"
end

def deal_cards!(p_hand, d_hand, dck)
  dck = FULL_SET_OF_CARDS.clone if dck.size < 10

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
  hand.map do |card|
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
    if value_array.sum > GOAL_POINT_TOTAL
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
  total_hand_value(hand) > GOAL_POINT_TOTAL
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

card_template = ["┌---------┐   ",
                 "| S       |   ",
                 "|         |   ",
                 "|   _N    |   ",
                 "|         |   ",
                 "|       S |   ",
                 "└---------┘   "]

def generate_pretty_card(card, crd_template)
  pretty_card = crd_template.map do |line|
    chars = line.chars
    chars.map! do |char|
      value_swap(char, card)
    end
    chars.join
  end
  pretty_card
end

=begin
this was my way of changing suits and values the template while keeping
cyclomatic complexity down. #value_swap and #ten_swap were in the
#generate_pretty_card
method. I couldn't figure out a way to get all of this done without all of
these branches. I tried an implementation with #map and []= assigning card
templates that only needed 4 else/if statements but it was mutating my
card_template array and I couldn't figure out a way to not do that.
so the generate_pretty_card method looked something like

def generate_pretty_card(card, crd_template)
  pretty_card = crd_template.map do |line|
    if line.include?("S")
      line[line.index("S")] = suit
    elsif line.include?("_") && value == "10"
      line[line.index("_")] = "1"
    elsif line.include?("_")
      line[line.index("_")] = " "
    elsif line.include?("N") && value == "10"
      line[line.index("N")] = "0"
    elsif line.include?("N")
      line[line.index("N")] = value
    end
  end
end

But then the card template would be mutated, my program would make the correct
changes for the first card, but the other cards would run on the changed
template which means they didn't encounter "S", "N", "_".
Hard coding the spots in the template
to put things just seemed a little cheaty. Like saying suit goes
in card_template[1][2] and card_template[5][7] so put it there every time
didn't seem good. You can be more flexible with the card design if you
just have the markers that the program's looking for instead of hard
coding a spot. If you change card size ever you'd have to rewrite everything.

What are your thoughts?

There's probably a better way to do all of this but I've spent a lot of time
puzzling over this and getting something that rubocop accepts and works in
the game feels like an accomplishment for now.
=end

def value_swap(char, card)
  value = card[1]
  suit = suit_swap(card)

  if char == "S"
    suit
  elsif value == "10"
    ten_swap(char)
  elsif char == "_"
    " "
  elsif char == "N"
    value
  else
    char
  end
end

def ten_swap(char)
  if char == "_"
    "1"
  elsif char == "N"
    "0"
  else
    char
  end
end

def generate_pretty_hand(hand, crd_template)
  # the dealer hand when passed to this method is just one card, so passing
  # it to the other part of this method would just pass the suit and not the
  # value
  if hand.flatten.size == 2  
    pretty_card_hand = generate_pretty_card(hand, crd_template)
    return pretty_card_hand
  elsif hand.flatten.size > 2
    pretty_card_hand = hand.map do |card|
      generate_pretty_card(card, crd_template)
    end
  end
  reformat_hand_for_display(pretty_card_hand)
  pretty_card_hand[0]
end

def reformat_hand_for_display(pretty_card_hand)
  pretty_card_hand.each do |pretty_card|
    unless pretty_card == pretty_card_hand[0]
      (0..6).each do |n|
        pretty_card_hand[0][n] << pretty_card[n]
      end
    end
  end
end

def display_hand(hand)
  hand.each do |line|
    puts line
  end
end

def display_hands(player_h, dealer_h, turn, crd_template)
  player_total = total_hand_value(player_h)
  dealer_total = total_hand_value(dealer_h)
  prompt "PLAYER HAND"
  pretty_player_h = generate_pretty_hand(player_h, crd_template)
  display_hand(pretty_player_h)
  prompt "player total: #{player_total}"
  prompt "DEALER HAND"
  if turn == "player"
    pretty_dealer_h = generate_pretty_hand(dealer_h[0], crd_template)
    display_hand(pretty_dealer_h)
  elsif turn == "dealer"
    pretty_dealer_h = generate_pretty_hand(dealer_h, crd_template)
    display_hand(pretty_dealer_h)
    prompt "dealer total: #{dealer_total}"
  end
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

def win_counter!(winner, d_wins, p_wins)
  if winner == "dealer"
    d_wins[0] += 1
  elsif winner == "player"
    p_wins[0] += 1
  end
end

def display_win_count(d_wins, p_wins)
  prompt "Dealer: #{d_wins.sum} wins."
  prompt "Player: #{p_wins.sum} wins."
end

def check_for_grand_champion(d_wins, p_wins)
  if d_wins.sum >= GRAND_CHAMPION_COUNT
    "dealer"
  elsif p_wins.sum >= GRAND_CHAMPION_COUNT
    "player"
  end
end

def display_grand_champion(grand_champion)
  system "clear"
  prompt "#{grand_champion.upcase} is the grand champion!"
  sleep(3)
  2.times do
    system "clear"
    twinkles
  end
  prompt "YAY #{grand_champion.upcase}!!!!"
end

def twinkles
  3.times do
    system "clear"
    puts "||||||||||||||||||||||||"
    sleep(0.25)
    system "clear"
    puts "////////////////////////"
    sleep(0.25)
    system "clear"
    puts "------------------------"
    sleep(0.25)
    system "clear"
    puts "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
    sleep(0.25)
    system "clear"
  end
end

def next_round!(player_hnd, dealer_hnd)
  player_hnd.clear
  dealer_hnd.clear
  prompt "press enter to deal the next hand!"
  gets.chomp
end

system "clear"
player_education
gets
loop do
  deal_cards!(player_hand, dealer_hand, deck)
  loop do
    turn = "player"
    system "clear"
    display_hands(player_hand, dealer_hand, turn, card_template)
    prompt "Do you want to hit or stay? Type your answer!"
    action = gets.chomp.downcase[0]
    if action == "h"
      hit!(player_hand, deck)
    elsif action == "s"
      break
    else
      system "clear"
      prompt "sorry, didn't understand that"
      sleep(2.5)
    end
    if busted?(player_hand)
      turn = "dealer"
      display_hands(player_hand, dealer_hand, turn, card_template)
      prompt "You busted. Oops."
      winner = "dealer"
      win_output("dealer")
      break
    end
  end
  loop do
    break if busted?(player_hand)
    system "clear"
    turn = "dealer"
    if total_hand_value(dealer_hand) < DEALER_THRESHHOLD
      hit!(dealer_hand, deck)
      display_hands(player_hand, dealer_hand, turn, card_template)
      if busted?(dealer_hand)
        prompt "The dealer busted!"
        winner = "player"
        win_output("player")
        break
      end
    else
      display_hands(player_hand, dealer_hand, turn, card_template)
      winner = check_for_win(player_hand, dealer_hand)
      win_output(winner)
      break
    end
  end
  win_counter!(winner, dealer_wins, player_wins)
  display_win_count(dealer_wins, player_wins)
  grand_champ = check_for_grand_champion(dealer_wins, player_wins)
  if grand_champ
    display_grand_champion(grand_champ)
    break
  end
  next_round!(player_hand, dealer_hand)
end

prompt "OK COOL THANKS FOR PLAYING THEN HAVE A GOOD ONE"
