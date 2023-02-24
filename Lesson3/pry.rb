require "pry"


a = [1, 2, 3, 4, 5]

a.each do |num|
  binding.pry
  num + 1
  if 2 == 3
    next
  else
    puts "ay"
  end
end