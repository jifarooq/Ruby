require './00_tree_node.rb'
class KnightPathFinder
  KNIGHT_OFFSETS = [
    [-2,  1], 
    [ 2,  1], 
    [ 2, -1], 
    [-2, -1], 
    [ 1,  2], 
    [-1,  2], 
    [ 1, -2], 
    [-1, -2]
  ]
  
  attr_reader :root
  
  def initialize(start_pos = [0, 0])
    @start_pos = start_pos
    @visited_positions = [start_pos]
  end
  
  def find_path(end_pos)
     build_move_tree.dfs(end_pos).trace_path_back
  end
  
  def self.valid_moves(pos)
    moves = []
    KNIGHT_OFFSETS.each do |combo|
      moves << [ combo[0] + pos[0], combo[1] + pos[1] ]
    end
    moves.select{ |move| move.all? { |coord| coord.between?(0, 7) } }
  end
  
  def new_move_positions(pos)
    valid_positions = self.class.valid_moves(pos) - @visited_positions
    @visited_positions += valid_positions
    valid_positions
  end
  
  def build_move_tree
    @root = PolyTreeNode.new(@start_pos)
    queue = [@root]
    until queue.empty?
      node = queue.shift
      new_move_positions(node.value).each do |new_pos|
        new_node = PolyTreeNode.new(new_pos)
        new_node.parent = node
        queue.concat(node.children)
      end
    end
    @root
  end
end

#test code
test = KnightPathFinder.new([0,0])
test.find_path([7, 7])

# all_positions = []
# (0..7).each do |row|
#   (0..7).each do |col|
#     all_positions << [row, col]
#   end
# end
#
# all_step_counts = []
# all_positions.each do |start_pos|
#   all_positions.each do |end_pos|
#     all_step_counts << KnightPathFinder.new(start_pos).find_path(end_pos).size
#   end
# end
#
# all_positions.each do |end_pos|
#   p KnightPathFinder.new([0,0]).find_path(end_pos).size, end_pos
# end
#
# KnightPathFinder.new([7,7]).find_path([0,0])
