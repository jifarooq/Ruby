class Array
  
  def my_each(&blk)
    self.length.times do |n|
      yield(self[n])
    end
  end
  
end

# tests
array = [1, 2, 3, 4, 5]

array.my_each do |element|
  puts element * 2
end