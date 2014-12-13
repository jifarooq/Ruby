def factors(num)
  1.upto(num).to_a.select { |factor| num % factor == 0 }
end