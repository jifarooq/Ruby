# recursion is good for traversing tree structures

def doer arg
  if block_given?
    yield 
    yield
  else 
    puts "where's the block?"
  end
end

def doer
    yield 
    yield
end

def doer2(arg, &blck)
  if block_given?
    yield arg
  else 
    puts "where's the block?"
  end
end

def do_each(names, proc)
  names.each do |name|
    proc.call name
  end
  
  proc
end

names = ["Bob", 'billy', 'sue']

#1 way to make proc
proc = Proc.new { |name| puts "#{name} has no last name" }

#lambda way

do_each(names, proc) 


def measure (num_repeats = 1)
  t1 = Time.now
  num_repeats.times {yield}
  (Time.now - t1) / num_repeats
end