require_relative 'Node.rb'
#include Node
class Lindkedlist
  def initialize
    @root = nil
    @tail = nil
  end

  private

  def add_elements(elements)
    arr = elements.split(',')
    for each_element in arr
      new_node = Node.new(each_element.to_i)
      if @root == nil
        @root = new_node
        @tail = new_node
      else
        @tail.right = new_node
        new_node.left = @tail
        @tail = new_node
      end
    end
  end
  def search(element)
    temp_node = @root
    while temp_node!=nil
      if temp_node.data == element
        break
      end
      temp_node = temp_node.right
    end
    if temp_node == nil
      puts "Element not present"
    else
      puts "Element is in the linked list"
    end
  end
  def delete(element)
    temp_node = @root
    while temp_node!=nil
      if temp_node.data == element
        break
      end
      temp_node = temp_node.right
    end
    if temp_node == nil
      puts "Element not present"
    else
      if temp_node.left!=nil
        temp_node.left.right=temp_node.right
      end
      if temp_node.right!=nil
        temp_node.right.left=temp_node.left
      end
    end
  end
  def print_all_elements
    temp_node = @root
    while temp_node!=nil
      print "#{temp_node.data} "
      temp_node = temp_node.right
    end
  end
  def swap_node(node1,node2)
    if node1.right!=nil
      node1.right.left = node2
    end
    if node1.left!=nil
      node1.left.right = node2
    end
    if node2.right!=nil
      node2.right.left = node1
    end
    if node2.left!=nil
      node2.left.right = node1
    end
    temp = node1.right
    node1.right = node2.right
    node2.right = temp
    temp = node1.left
    node1.left = node2.left
    node2.left = temp
  end
  def reverse_LL
    node1 = @root
    node2 = @tail
    while node1!=node2
      swap_node(node1,node2)
      node2 = node2.right
      node1 = node1.left
    end
    temp = @root
    @root = @tail
    @tail = temp
  end

  def save_to_file(filename)
    f= File.open(filename,'w')
    temp_node = @root
    while temp_node!=nil
      f.write(temp_node.data.to_s)
      f.write(",")
      temp_node = temp_node.right
    end
  end

  public

  def save_helper(*args)
    if args[0]==nil
      puts "Enter filename to save data"
      inp = STDIN.gets.chomp
    else
      inp = args[0]
      save_to_file(inp)
    end
  end

  def reverse_helper
    puts "Reversed elements"
    reverse_LL
    print_all_elements
  end

  def search_helper
    puts "Enter element to be search"
    inp = STDIN.gets.chomp
    if inp.to_i.to_s==inp
      search(inp.to_i)
    else
      puts "enter valid input"
      search_helper
    end
  end

  def add_elements_helper
    puts "Enter comma separated elements"
    inp = STDIN.gets.chomp
    add_elements(inp)
  end

  def print_helper
    puts "All the data of linked list are"
    print_all_elements
    puts "\n"
  end

  def delete_helper
    puts "enter element to be deleted"
    inp = get.chomp
    delete(inp.to_i)
  end

  def load_helper(*args)
    if args[0]==nil
      puts "Enter filename"
      inp = STDIN.gets.chomp
    else
      inp = args[0]
      f = File.open(inp)
      add_elements(f.read)
    end
  end

end
# new_ll = Lindkedlist.new
# new_ll.add_elements("9,3,2,4,4")
# new_ll.print_all_elements
# new_ll.search(9)
# new_ll.delete(2)
# new_ll.print_all_elements