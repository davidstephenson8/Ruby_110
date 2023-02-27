flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flinty_hash = {}

flintstones.each_with_index do |name, index|
  flinty_hash[name] = index + 1
end

p flinty_hash
