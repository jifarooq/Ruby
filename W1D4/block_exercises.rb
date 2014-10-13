class Array
  
  def my_each(&proc)
    self.length.times do |idx|
      proc.call(self[idx])
    end 
  end
  
  def my_map(&proc)
    result = []
    self.my_each do |element|
      result << proc.call(element)
    end
    result
  end
  
  def my_select(&proc)
    result = []
    self.my_each do |element|
      result << element if proc.call(element)
    end
    result
  end
  
  def my_inject(&proc)
    result = self.first
    self[1..-1].my_each do |el|
      result = proc.call(result, el)
    end
    result
  end
  
  def my_sort!(&proc)
    sorted = false

    until sorted
      sorted = true

      (0...self.length - 1).each do |idx|

        if proc.call(self[idx], self[idx + 1]) == 1
          self[idx], self[idx +1] = self[idx +1 ], self[idx]
          sorted = false
        end
        
      end

    end
    self
  end
  
  def my_sort(&proc)
    self.dup.my_sort! &proc
  end
  
end

#does not return puts string
def eval_block(*args, &proc)
  unless block_given?
    return "NO BLOCK GIVEN!"
  end
    proc.call(*args)
end