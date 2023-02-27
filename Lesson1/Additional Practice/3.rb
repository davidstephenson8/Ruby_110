ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

youngs = ages.select do |_, age|
  age < 100
end

p youngs