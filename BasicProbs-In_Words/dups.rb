class Array
  def my_uniq
    new_array = []
    
    self.each do |element|
      new_array << element unless new_array.include?(element)
    end
    
    new_array
  end
end

array = [1, 2, 1, 3, 3]
p array
p array.my_uniq