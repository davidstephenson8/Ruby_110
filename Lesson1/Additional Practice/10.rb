munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, hash|
  if hash["age"] < 18
    hash["age_group"] = "kid"
  elsif hash["age"] > 64
    hash["age_group"] = "senior"
  else
    hash["age_group"] = "adult"
  end
end

p munsters