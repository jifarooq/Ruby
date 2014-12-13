require 'set'

def substrings(str)
  substrings = []
  
  (0...str.length).each do |i|
    (i...str.length).each do |j|
      substrings << str[i..j]
    end
  end
    
  substrings
end

def subwords(string)
  dict = Set.new
  
  File.readlines("dictionary.txt").each do |line|
    dict.add(line.chomp)
  end
  
  substrings(string).select{ |substr| dict.include?(substr)}
end