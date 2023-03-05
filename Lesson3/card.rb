#require "pry"

def generate_card(pretty_card)
  suit = pretty_card[0]
  value = pretty_card[1]
  card_template = ["┌---------┐   ",
                   "| S       |   ",
                   "|         |   ", 
                   "|   _9    |   ",
                   "|         |   ",
                   "|       S |   ",
                   "└---------┘   "
                   ]
  card_template[1][2] = suit
  card_template[3][4] = "1" if value == "10"
  card_template[3][4] = " " if value != "10"
  card_template[3][5] = "0" if value == "10"
  card_template[3][5] = value if value != "10"
  card_template[5][8] = suit
  card_template
end

def display_card(pretty_card)
  card = generate_card(pretty_card)
  card.each do |line|
    puts line
  end
end

display_card(["♠", "K"])
display_card(["♠", "10"])
