def my_transpose(array)
  new_array = Array.new(array.size) { Array.new(array.size) }
  
  (0...array.length).each do |i|
    (0...array.length).each do |j|
      new_array[i][j] = array[j][i]
    end
  end
  
  p new_array
  new_array
end

my_transpose([
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8]
])