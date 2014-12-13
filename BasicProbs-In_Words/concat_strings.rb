def concat_string(array)
  array.inject("") { |string, element| string + element }
end



# tests
array = ["a", "b", "c"]
puts concat_string(array)