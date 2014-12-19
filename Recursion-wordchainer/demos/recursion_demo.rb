#every problem has a base case, which it must reduce to.  Also think about 1 level up from base case

def factorial(num)
  return 1 if num == 0
  num * factorial(num - 1)
end

def str_reverser(str, times = 0)
  return str if str.length <= 1
  end_bit = str[0...-1]
  str[-1] + str_reverser(end_bit, times += 1)
end

def arr_reverser(arr) 
  return [arr.first] if arr.size <= 1
  [arr.pop] + arr_reverser(arr)
end

#FUNNY
def shitty_sort(ary)
  return ary if ary.sort == ary
  puts ary
  return shitty_sort( ary.shuffle )
end