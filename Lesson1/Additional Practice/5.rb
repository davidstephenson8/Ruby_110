flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

a = ''

flintstones.each do |name|
  if name[0, 2] == "Be"
    a = name
  end
end

p a