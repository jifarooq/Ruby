DIGITS = {
  0 => '0',
  1 => '1',
  2 => '2',
  3 => '3',
  4 => '4',
  5 => '5',
  6 => '6',
  7 => '7',
  8 => '8',
  9 => '9',
  10 => 'A',
  11 => 'B',
  12 => 'C',
  13 => 'D',
  14 => 'E',
  15 => 'F'
 }

def num_to_string(number, base)
  if number < base
    return DIGITS[number]
  else
    return num_to_string(number / base, base) + DIGITS[number % base]
  end
end

p num_to_string(5, 10) #=> "5"
p num_to_string(5, 2)  #=> "101"
p num_to_string(5, 16) #=> "5"

p num_to_string(234, 10) #=> "234"
p num_to_string(234, 2)  #=> "11101010"
p num_to_string(234, 16) #=> "EA"


=begin
def push_to_string(number, base)  
  if number < base
    return DIGITS[number]
  else
    return push_to_string(number / base, base) << DIGITS[number%base]
  end
end
=end