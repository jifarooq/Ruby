def caesar(string, shift)
  new_string = ''
  
  (0...string.length).each do |index|
    char = string[index]
    shift.times { char = char.next[0] } 
    new_string << char
  end
    
  new_string
end

p caesar('abc', 3)
p caesar("hello", 3) # => "khoor"