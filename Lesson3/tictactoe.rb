require "pry"

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

player_wins = 0
computer_wins = 0

def prompt(msg)
  puts "--> #{msg}"
end

def display_board(brd)
  system "clear"
  puts ""
  puts "     |      |"
  puts "  #{brd[1]}  |  #{brd[2]}   |  #{brd[3]}"
  puts "     |      |"
  puts "-----+------+-----"
  puts "     |      |"
  puts "  #{brd[4]}  |  #{brd[5]}   |  #{brd[6]}"
  puts "     |      |"
  puts "-----+------+-----"
  puts "     |      |"
  puts "  #{brd[7]}  |  #{brd[8]}   |  #{brd[9]}"
  puts "     |      |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def tutorial_board
  new_board = {}
  (1..9).each { |num| new_board[num] = num }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, separator = ",", last_connector = "or")
  if arr.size == 0
    return ''
  elsif arr.size == 1
    return arr[0]
  else 
    arr[-1] = " #{last_connector} #{arr[-1]}"
    arr[0, arr.size - 1].join("#{separator} ") << arr[-1]
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose one of the following squares: #{joinor(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd) == []
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  winning_lines.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return "Player"
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return "Computer"
    end
  end
  nil
end

def rules
  system "clear"
  puts "Tic Tac Toe is played with players taking turns placing their respective pieces in a 3 by 3 grid"
  puts "with each player attempting to place three pieces consecutively. Three pieces can be placed in the"
  puts "same row, same colomn, or same diagonal to win the game. In our game, each area of the grid corresponds"
  puts "to a number from 1 to 9."
  puts ""
  puts "Press enter to display the grid with each area labelled with its correcponding number."
  gets
  board = tutorial_board
  display_board(board)
  puts "Ok! Ready to go! Press enter to play!"
  gets
end

def detect_grand_champion(player, computer)
  if player >= 5 
    player_celebration
    player_wins = 0
    computer_wins = 0
  elsif computer >= 5
    computer_celebration
    player_wins = 0
    computer_wins = 0
  else nil
  end
end

def player_celebration
  num = 0
  puts "CONGRATULATIONS YOU ARE THE GRAND CHAMPION"
  sleep 1
  3.times do |_|
    until num == 5
      num += 1
      puts "*" * num
      sleep 0.25
    end
    until num == 0
      num -= 1
      puts "*" * num
      sleep(0.25)
    end
  end
end

rules

loop do
  board = initialize_board

  loop do
    display_board(board)

    player_places_piece!(board)
    break if board_full?(board) || someone_won?(board)

    computer_places_piece!(board)
    break if board_full?(board) || someone_won?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
    case detect_winner(board)
    when "Player"
      player_wins += 1
    when "Computer"
      computer_wins += 1
    end
  else
    prompt "It's a tie!"
  end
  player_wins = 5
  detect_grand_champion(player_wins, computer_wins)

  prompt "Number of computer wins: #{computer_wins}"
  prompt "Number of player wins: #{player_wins}"
  prompt "First to 5 is the GRAND CHAMPION"
  prompt "Play again?"
  answer = gets.chomp
  break if answer[0].downcase != 'y'
end

prompt "Thanks for playing cutie"
