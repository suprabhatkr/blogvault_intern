#Node class type
class Node
  attr_accessor :data,:left,:right
  def initialize(data)
    @data = data
    @left = NIL
    @right = NIL
  end
  def add_right_child(node)
    @right = node
  end
  def add_left_child(node)
    @left = node
  end
end

#container for each BST
class BST
  def initialize
    @root = NIL #root of the tree
    @buffer_arr = Array.new #array used to store temporary data in various operations
    @filename = 'bst_data.txt' #default external file to store BST data
  end

  private

  #method for adding a single node
  def add_one_node(root,given_node)
    if root == NIL
      @root = given_node
    else
      while (root.data>given_node.data and root.left!=NIL) or (root.data<given_node.data and root.right!=NIL)
        if root.data>given_node.data
          root = root.left
        else
          root = root.right
        end
      end
      if root.data == given_node.data
        puts "duplicate data #{given_node.data}. Not adding"
      elsif root.data>given_node.data
        root.left = given_node
      else
        root.right = given_node
      end
    end
  end

  # method for adding multiple node at once
  def add_elements(elements)
    if elements.length == 0
      puts "there is no element to add,please provide elements"
    else
      begin
        elements = elements.split(',')
        for i in (0...elements.length)
          if elements[i].to_i.to_s == elements[i]
            elements[i] = elements[i].to_i
          else
            puts "enter the data again (press \"quit\" for quit)"
            elements = gets.chomp
            if elements=="quit"
              return
            else
              add_elements(elements)
              return
            end
            return
          end
        end
      rescue => r
        puts r
      end
      for each_element in elements
        new_node = Node.new(each_element)
        add_one_node(@root,new_node)
      end
    end
  end

  #method to print the largest element of BST
  def print_largest_element
    curr_node = @root
    if curr_node == NIL
      puts "There is no data"
    else
      while curr_node.right != NIL
        curr_node = curr_node.right
      end
      puts curr_node.data
    end
  end

  #method to print the smallest element of BST
  def print_smallest_element
    curr_node = @root
    if curr_node == NIL
      puts "There is no data"
    else
      while curr_node.left != NIL
        curr_node = curr_node.left
      end
      puts curr_node.data
    end
  end

  #method to print all the data in inorder way
  def inorder_traversal(root=@root)
    if root.left!=NIL
      inorder_traversal(root.left)
    end
    print root.data
    print " "
    if root.right!=NIL
      inorder_traversal(root.right)
    end
    if root == @root
      print "\n"
    end
  end

  #method to print all the data in preorder way
  def preorder_traversal(root=@root)
    print root.data
    print " "
    if root.left!=NIL
      preorder_traversal(root.left)
    end
    if root.right!=NIL
      preorder_traversal(root.right)
    end
    if root == @root
      print "\n"
    end
  end

  #method to print all the data in postorder way
  def postorder_traversal(root=@root)
    if root.left!=NIL
      postorder_traversal(root.left)
    end
    if root.right!=NIL
      postorder_traversal(root.right)
    end
    print root.data
    print " "
    if root == @root
      print "\n"
    end
  end

  #method to print all the data in level order way
  def levelorder_traversal(root=@root)
    buffer_arr = @buffer_arr
    buffer_arr.append(root)
    curr_ind = 0
    while curr_ind<buffer_arr.length
      curr_node = buffer_arr[curr_ind]
      print "#{curr_node.data} "
      if curr_node.left != NIL
        buffer_arr.append(curr_node.left)
      end
      if curr_node.right != NIL
        buffer_arr.append(curr_node.right)
      end
      curr_ind+=1
    end
    @buffer_arr.clear
  end

  #method for searching an element, it also returns the corresponding node
  def search(element)
    root = @root
    if root == NIL
      puts "no element in the BST"
      return NIL
    else
      while (root.data>element and root.left!=NIL) or (root.data<element and root.right!=NIL)
        if root.data>element
          root = root.left
        else
          root = root.right
        end
      end
      if root.data == element
        puts "Data is present in BST"
        return root
      else
        puts "Data is not present in BST"
        return NIL
      end
    end
  end

  #method to remove an element if it is present in BST
  def remove(element)
    root = @root
    if root == NIL
      puts "no element in the BST"
    elsif root.data == element
      if root.left != NIL
        @root = root.left
        curr_node = root.left
        while curr_node.right!=NIL
          curr_node = curr_node.right
        end
        curr_node.right = root.right
      else
        @root = root.right
      end
      puts "Node deleted"
    else
      while (root.data>element and root.left!=NIL) or (root.data<element and root.right!=NIL)
        if root.data>element
          #when data to be removed is left child of current node
          if root.left.data==element
            temp_root = root.left
            if temp_root.left != NIL
              root.left = temp_root.left
              curr_node = temp_root.left
              while curr_node.right!=NIL
                curr_node = curr_node.right
              end
              curr_node.right = temp_root.right
            else
              root.left = temp_root.right
            end
            puts "Node deleted"
            return
          else
            root = root.left
          end
        else
          #when data to be removed is right child of current node
          if root.right.data==element
            temp_root = root.right
            if temp_root.left != NIL
              root.right = temp_root.left
              curr_node = temp_root.left
              while curr_node.right!=NIL
                curr_node = curr_node.right
              end
              curr_node.right = temp_root.right
            else
              root.right = temp_root.right
            end
            puts "Node deleted"
            return
          else
            root = root.right
          end
        end
      end
      puts "Data is not in the BST"
    end
  end

  #method to print all path from root to leaves
  def print_all_path(root=@root)
    @buffer_arr.append(root)
    if root.left!=NIL
      print_all_path(root.left)
    end
    if root.right!=NIL
      print_all_path(root.right)
    end
    if root.left==NIL and root.right==NIL
      for each_element in @buffer_arr
        print "#{each_element.data} "
      end
      print "\n"
    end
    @buffer_arr.pop()
  end

  #method to write data in external file in preorder fashion
  def preorder_traversal_to_file(root=@root,f)
    f.write root.data
    f.write ","
    if root.left!=NIL
      preorder_traversal_to_file(root.left,f)
    end
    if root.right!=NIL
      preorder_traversal_to_file(root.right,f)
    end
  end
  def save_to_file(filename=@filename)
    f = File.open(filename,'w')
    preorder_traversal_to_file(@root,f)
    f.close
  end

  public

  #method to load data from external file
  def load_BST_from_file(filename=@filename)
    begin
      f = File.open(filename,'r')
      add_elements(f.read)
    rescue => r
      puts r
    end
  end

  #method to perform various operations on BST
  def perform_operations
    puts "\nSelect any one of the option"
    puts "1. Add elements to tree"
    puts "2. Print largest element"
    puts "3. Print smallest element"
    puts "4. Print inorder traversal"
    puts "5. Print preorder traversal"
    puts "6. Print postorder traversal"
    puts "7. Print level order traversal"
    puts "8. Search an element"
    puts "9. Remove an element"
    puts "10. Print all Paths"
    puts "11. Quit"
    selected_option = gets.chomp.to_i
    case selected_option
    when 1
      puts "enter comma separated elements"
      elements = gets.chomp
      add_elements(elements)
      perform_operations
    when 2
      puts "largest element"
      print_largest_element
      perform_operations
    when 3
      puts "smallest element"
      print_smallest_element
      perform_operations
    when 4
      puts "inorder traversal"
      inorder_traversal
      perform_operations
    when 5
      puts "preorder traversal"
      preorder_traversal
      perform_operations
    when 6
      puts "postorder traversal"
      postorder_traversal
      perform_operations
    when 7
      puts "levelorder traversal"
      levelorder_traversal
      perform_operations
    when 8
      puts "enter element to be search. Press \"quit\" for quitting"
      correct_input = false
      unless  correct_input
        begin
          element = gets.chomp
          if element == "quit"
            perform_operations
            return
          elsif element.to_i.to_s == element
            element = element.to_i
            search(element)
            perform_operations
          else
            puts "enter only integer data (\"quit\" for quitting)"
            correct_input = false
          end
          correct_input = true
        rescue => r
          puts r
        end
      end
    when 9
      puts "enter element to be removed. Press \"quit\" for quitting"
      correct_input = false
      unless  correct_input
        begin
          element = gets.chomp
          if element == "quit"
            perform_operations
            return
          elsif element.to_i.to_s == element
            element = element.to_i
            remove(element)
            perform_operations
          else
            puts "enter only integer data (\"quit\" for quitting)"
            correct_input = false
          end
          correct_input = true
        rescue => r
          puts r
        end
      end
    when 10
      puts "printing all paths"
      print_all_path
      perform_operations
    when 11
      save_to_file
      return
    else
      puts "enter option correctly"
    end
  end
end

#creating an instance of BST class
new_bs = BST.new

while true
  puts "HOME PAGE"
  puts "Enter the corresponding option"
  puts "1. Load data from external file"
  puts "2. perform operations on BST"
  puts "3. Quit"
  input = gets.chomp
  case input
  when "1"
    new_bs.load_BST_from_file
  when "2"
    new_bs.perform_operations
  when "3"
    break
  else
    puts "enter correct options"
  end
end