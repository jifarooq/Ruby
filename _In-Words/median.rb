def median(array)
  array.sort!
  
  if array.length.odd?
    array[array.length / 2]
  else
    (array[array.length / 2] + array[array.length / 2 - 1]).to_f / 2
  end
end

# tests
array = [1, 2, 3, 4, 5]
array_two = [1, 2, 3, 4, 5, 6]
puts median(array)
puts median(array_two)