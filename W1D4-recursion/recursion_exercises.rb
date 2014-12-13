def range(start_num, end_num)
  return [] if end_num < start_num
  result = [start_num]
  result += range(start_num + 1, end_num)
  result
end

def iterative_sum(arr)
  arr.reduce(:+)
end

def recursive_sum(arr)
  return 0 if arr[0] == nil
  arr[0] + recursive_sum(arr[1..-1])
end

def recursive_exp1(base, exp)
  return 1 if exp == 0
  base * recursive_exp1(base, exp - 1)
end

def recursive_exp2(base, exp)
  return 1 if exp == 0
  return base if exp == 1
  return recursive_exp2(base, exp/2) ** 2 if exp.even?
  return base * (recursive_exp2(base, (exp - 1) /2) ** 2) if exp.odd?
end

def deep_dup(object)
  return object unless object.is_a?(Array)
  result = []
  object.each do |element|
    result << deep_dup(element)
  end
  result
end

def fibonacci(num)
  return [0] if num == 1
  return [0,1] if num == 2
  result = []
  result += fibonacci(num - 1)
  result << result[-1] + result[-2]
  result
end

def bsearch(array, target)
  middle_index = array.length / 2
  return middle_index if array[middle_index] == target
  
  if array[middle_index] < target
    result = bsearch(array[middle_index..-1], target) + middle_index
  else
    result = bsearch(array[0...middle_index], target)    
  end
 
  result
end

def make_change(amount, coins = [25, 10, 5, 1])
  return Array.new(amount, 1) if coins == [1]
  if amount >= coins[0]
    scenario1 = make_change(amount, coins[1..-1])
    scenario2 = [coins[0]]
    scenario2 += make_change(amount - coins[0], coins)
  else
    return make_change(amount, coins[1..-1])  
  end
  if scenario1.length < scenario2.length
    scenario1
  else
    scenario2
  end
end

def merge_sort(arr)
  return [] if arr.empty?
  return arr if arr.size == 1

  middle_index = (arr.size - 1) / 2
  sorted_first_half = merge_sort( arr[0..middle_index] ) 
  sorted_second_half = merge_sort( arr[middle_index+1 .. -1 ] ) 
  
  merge(sorted_first_half, sorted_second_half)
end

def merge (arr1, arr2)
  result = []
  until arr1.empty? || arr2.empty?
    result << (arr1[0] < arr2[0] ? arr1.shift : arr2.shift)
  end
  
  result += arr1.empty? ? arr2 : arr1
  result
end

def subsets(arr)
  return [[]] if arr.empty?
  smaller_set = subsets(arr[0...-1])
  smaller_set | smaller_set.map {|set| set << arr[-1]}
end