class Array
  def two_sum
    new_array = []
    
    (0...self.length - 1).each do |i|
      ((i + 1)...self.length).each do |j|
        if self[i] + self[j] == 0
          new_array << [i, j]
        end
      end
    end
    
    new_array
  end
end

array = [-1, 0, 2, -2, 1]
p array
p array.two_sum