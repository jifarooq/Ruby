ONES = {
    0 => 'zero',
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine'
}

TEENS = {
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen'
}

TENS = {
  20 => 'twenty',
  30 => 'thirty',
  40 => 'forty',
  50 => 'fifty',
  60 => 'sixty',
  70 => 'seventy',
  80 => 'eighty',
  90 => 'ninety'
}

MAGNITUDES = {
  100 => 'hundred',
  1000 => 'thousand',
  1_000_000 => 'million',
  1_000_000_000 => 'billion',
  1_000_000_000_000 => 'trillion'
}

class Fixnum
  
  def in_words
    
    case self
    when 0..9
      ONES[self]
    when 10..19
      TEENS[self]
    when 20..99
      tens_word = TENS[ (self / 10) * 10 ]
      remainder = self % 10
      remainder > 0 ? tens_word + ' ' + ONES[remainder] : tens_word
    else 
      magnitude = find_magnitude
      
      magnitude_words = (self / magnitude).in_words + " " + MAGNITUDES[magnitude]
      (self % magnitude) > 0 ? magnitude_words + ' ' + (self % magnitude).in_words : magnitude_words
    end
  end
  
  def find_magnitude
    MAGNITUDES.keys.select { |magnitude| magnitude <= self }.last
  end
  
end