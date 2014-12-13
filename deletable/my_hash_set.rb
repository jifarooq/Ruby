class MyHashSet
  
  attr_reader :store
  
  def initialize
    @store = {}
  end
  
  def insert(el)
    @store[el] = true
  end
  
  def include?(el)
    @store[el]
  end
  
  def delete(el)
    if include?(el) 
      @store.delete[el]
      true
    else
      false
    end    
  end
  
  def to_a
    @store.keys
  end
  
  def union(other_set)
    store.merge(other_set.store)
  end
  
  def intersect(other_set)
    new_hash = Hash.new
    array = store.keys & other_set.store.keys
    
    array.each do |element|
      new_hash[element] = true
    end
    
    new_hash
  end
  
  def minus(other_set)
    new_hash = Hash.new
    array = store.keys - other_set.store.keys
    
    array.each do |element|
      new_hash[element] = true
    end
    
    new_hash
  end
  
end