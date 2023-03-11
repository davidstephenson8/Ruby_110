require "pry"

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

pretty_hand = generate_pretty_hand([["S", "10"], ["S", "K"], ["H", "A"]])
display_hand(pretty_hand)

pretty_hand = generate_pretty_hand([["H", "7"], ["D", "2"], ["H", "6"], ["C", "3"]])
display_hand(pretty_hand)

pretty_hand = generate_pretty_hand([["C", "5"], ["C", "6"], ["D", "7"]])
display_hand(pretty_hand)

pretty_hand = generate_pretty_hand([["C", "K"], ["H", "K"]])
display_hand(pretty_hand)

pretty_hand = generate_pretty_hand([["C", "7"], ["C", "4"], ["S", "7"]])
display_hand(pretty_hand)

pretty_hand = generate_pretty_hand([["S", "3"], ["C", "10"], ["S", "10"]])
display_hand(pretty_hand)

pretty_hand = generate_pretty_hand([["H", "8"], ["C", "J"]])
display_hand(pretty_hand)
