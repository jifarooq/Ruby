def remix(ingredients)
  alcohols = ingredients.map { |pair| pair.first }
  mixers = ingredients.flatten - alcohols
  combinations = []
  
  until combinations.length == ingredients.length
    alcohols.shuffle!
    mixers.shuffle!
    
    unless ingredients.include?([alcohols.last, mixers.last])
      combinations << [alcohols.pop, mixers.pop]
    end
  end
  
  combinations
end

remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])