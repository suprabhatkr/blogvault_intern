# #Node class type c
class Node
  attr_accessor :data,:left,:right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
  def add_right_child(node)
    @right = node
  end
  def add_left_child(node)
    @left = node
  end
end

