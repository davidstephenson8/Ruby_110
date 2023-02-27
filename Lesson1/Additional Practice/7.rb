statement = "The Flintstones Rock"

characters = statement.chars
p characters
counts = {}

characters.each do |letter|
  counts[letter] = characters.count(letter)
end

p counts