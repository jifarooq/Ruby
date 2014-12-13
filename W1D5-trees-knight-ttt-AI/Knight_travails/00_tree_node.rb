class PolyTreeNode
  attr_reader :parent, :children
  attr_accessor :value
  
  def initialize(value = nil)
    @parent = nil
    @children = []
    @value = value
  end
  
  def parent=(parent_node)
    # needed to remove child before reassigning parent
    self.parent.children.delete(self) if self.parent
    @parent = parent_node
    
    unless @parent.nil? || @parent.children.include?(self)
      @parent.children << self
    end
  end
  
  def add_child(child)
    child.parent = self
  end
  
  def remove_child(child)
    unless self.children.include?(child)
      raise "Not a child!"
    end
    child.parent = nil
  end
  
  def trace_path_back
    path, current = [], self
    until current.parent.nil?
      path << current.value
      current = current.parent
    end
    
    path << current.value
    path.reverse
  end

  def dfs(value)
    return self if self.value == value
    
    @children.each do |child|
      result = child.dfs(value)
      return result unless result.nil?
    end
    
    nil
  end


  def bfs(target)
    nodes = [self]
    
    until nodes.empty?
      first_node = nodes.shift
      return first_node if first_node.value == target
      nodes.concat(first_node.children)
    end

    nil
  end
end