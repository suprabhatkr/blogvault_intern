require_relative 'Tree.rb'
require_relative 'Node.rb'
include Tree_methods
#container for each BST

BST_OPERATION_HASH = Hash.new
BST_CATEGORY_HASH = Hash.new

def add_category(category_index,category_message)
  BST_OPERATION_HASH[category_index] = Hash.new
  BST_CATEGORY_HASH[category_index] = category_message
  category_index
end

def add_operation(operation_index,message,category_index)
  BST_OPERATION_HASH[category_index][operation_index]=message
  operation_index
end

module BST_OperationCategory
  PRINT = add_category(1, "Print")
  MODIFY = add_category(2, "Modify")
  SEARCH = add_category(3, "Search")
  LOAD = add_category(4,"Load Data")
end

module BST_Operations
  PRINT_PATHS = add_operation(1, "Print all the paths from root to leaves",BST_OperationCategory::PRINT)
  SMALLEST = add_operation(2, "Print the smallest element", BST_OperationCategory::PRINT)
  LARGEST = add_operation(3, "Print the largest element", BST_OperationCategory::PRINT)
  PRE_ORDER = add_operation(4, "Print the pre order traversal", BST_OperationCategory::PRINT)
  POST_ORDER = add_operation(5, "Print the post order traversal", BST_OperationCategory::PRINT)
  IN_ORDER = add_operation(6, "Print the in order traversal", BST_OperationCategory::PRINT)
  LEVEL_ORDER = add_operation(7, "Print the level order traversal", BST_OperationCategory::PRINT)
  SEARCH = add_operation(1, "Search an element by value", BST_OperationCategory::SEARCH)
  ADD_ELEMENTS = add_operation(1, "Add elements to the tree (comma seperated)", BST_OperationCategory::MODIFY)
  DELETE = add_operation(2, "Delete an element by value", BST_OperationCategory::MODIFY)
  LOAD_DATA = add_operation(1,"Load data from external file",BST_OperationCategory::LOAD)
end

class BST
  def initialize(args)
    @root = nil #root of the tree
    @buffer_arr = Array.new #array used to store temporary data in various operations
    @filename = args
  end

  private

  #method for adding a single node
  def add_one_node(root,given_node)
    if root == nil
      @root = given_node
    else
      while (root.data>given_node.data and root.left!=nil) or (root.data<given_node.data and root.right!=nil)
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
            elements = STDIN.gets.chomp
            system("clear")
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
    if curr_node == nil
      puts "There is no data"
    else
      while curr_node.right != nil
        curr_node = curr_node.right
      end
      puts curr_node.data
    end
  end

  #method to print the smallest element of BST
  def print_smallest_element
    curr_node = @root
    if curr_node == nil
      puts "There is no data"
    else
      while curr_node.left != nil
        curr_node = curr_node.left
      end
      puts curr_node.data
    end
  end

  #method for searching an element, it also returns the corresponding node
  def search(element)
    root = @root
    if root == nil
      puts "no element in the BST"
      return nil
    else
      while (root.data>element and root.left!=nil) or (root.data<element and root.right!=nil)
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
        return nil
      end
    end
  end

  #method to remove an element if it is present in BST
  def remove(element)
    root = @root
    if root == nil
      puts "no element in the BST"
    elsif root.data == element
      if root.left != nil
        @root = root.left
        curr_node = root.left
        while curr_node.right!=nil
          curr_node = curr_node.right
        end
        curr_node.right = root.right
      else
        @root = root.right
      end
      puts "Node deleted"
    else
      while (root.data>element and root.left!=nil) or (root.data<element and root.right!=nil)
        if root.data>element
          #when data to be removed is left child of current node
          if root.left.data==element
            temp_root = root.left
            if temp_root.left != nil
              root.left = temp_root.left
              curr_node = temp_root.left
              while curr_node.right!=nil
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
            if temp_root.left != nil
              root.right = temp_root.left
              curr_node = temp_root.left
              while curr_node.right!=nil
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
    if root.left!=nil
      print_all_path(root.left)
    end
    if root.right!=nil
      print_all_path(root.right)
    end
    if root.left==nil and root.right==nil
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
    if root.left!=nil
      preorder_traversal_to_file(root.left,f)
    end
    if root.right!=nil
      preorder_traversal_to_file(root.right,f)
    end
  end
  def save_to_file(filename=@filename)
    f = File.open(filename,'w')
    preorder_traversal_to_file(@root,f)
    f.close
  end

  public

  def save_helper
    if @filename==nil
      puts "Enter filename to save"
      inp = STDIN.gets.chomp
      system("clear")
    else
      inp = @filename
      save_to_file(inp)
    end
  end

  #method to load data from external file
  def load_BST_from_file_helper
    if @filename==nil
      puts "Enter filename"
      filename = STDIN.gets.chomp
      system("clear")
    else
      filename = @filename
      begin
        f = File.open(filename,'r')
        add_elements(f.read)
      rescue => r
        puts r
      end
    end
  end

  def add_elements_helper
    puts "enter comma separated elements"
    elements = STDIN.gets.chomp
    system("clear")
    add_elements(elements)
  end

  def largest_element_helper
    puts "largest element"
    print_largest_element
  end

  def smallest_element_helper
    puts "smallest element"
    print_smallest_element
  end

  def preorder_traversal_helper
    puts "Pre order Traversal"
    preorder_traversal(@root)
    puts "\n"
  end
  def inorder_traversal_helper
    puts "Inorder Traversal"
    inorder_traversal(@root)
    puts "\n"
  end

  def postorder_traversal_helper
    puts "Post order Traversal"
    postorder_traversal(@root)
    puts "\n"
  end

  def levelorder_traversal_helper
    puts "lever order traversal"
    levelorder_traversal
  end

  def search_helper
    puts "enter element to be search. Press \"quit\" for quitting"
    correct_input = false
    unless  correct_input
      begin
        element = STDIN.gets.chomp
        system("clear")
        if element == "quit"
          correct_input = true
        elsif element.to_i.to_s == element
          element = element.to_i
          search(element)
          correct_input = true
        else
          puts "enter only integer data (\"quit\" for quitting)"
          correct_input = false
        end
      rescue => r
        puts r
      end
    end
  end

  def remove_helper
    puts "enter element to be removed. Press \"quit\" for quitting"
    correct_input = false
    unless  correct_input
      begin
        element = STDIN.gets.chomp
        system("clear")
        if element == "quit"
          correct_input = true
        elsif element.to_i.to_s == element
          element = element.to_i
          remove(element)
          correct_input = true
        else
          puts "enter only integer data (\"quit\" for quitting)"
          correct_input = false
        end
      rescue => r
        puts r
      end
    end
  end

  def print_path_helper
    puts "All the paths are"
    print_all_path
  end

  def perform_operations(category_index)
    quit_pos=1
    for each_operation in BST_OPERATION_HASH[category_index].keys
      puts "#{each_operation} #{BST_OPERATION_HASH[category_index][each_operation]}"
      quit_pos+=1
    end
    puts "#{quit_pos} For quitting"
    inp = STDIN.gets.chomp
    system("clear")
    case category_index
    when BST_OperationCategory::PRINT
      case inp.to_i
      when BST_Operations::PRINT_PATHS then
        NEW_BST.print_path_helper
        ask_for_category
      when BST_Operations::IN_ORDER then
        NEW_BST.inorder_traversal_helper
        ask_for_category
      when BST_Operations::LEVEL_ORDER then
        NEW_BST.levelorder_traversal_helper
        ask_for_category
      when BST_Operations::PRE_ORDER then
        NEW_BST.preorder_traversal_helper
        ask_for_category
      when BST_Operations::POST_ORDER then
        NEW_BST.postorder_traversal_helper
        ask_for_category
      when BST_Operations::LARGEST then
        NEW_BST.largest_element_helper
        ask_for_category
      when BST_Operations::SMALLEST then
        NEW_BST.smallest_element_helper
        ask_for_category
      when quit_pos
        ask_for_category
      else
        puts "Please enter valid input"
        perform_operations(category_index)
      end
    when BST_OperationCategory::MODIFY
      case inp.to_i
      when BST_Operations::ADD_ELEMENTS then
        NEW_BST.add_elements_helper
        ask_for_category
      when BST_Operations::DELETE then
        NEW_BST.remove_helper
        ask_for_category
      when quit_pos
        ask_for_category
      else
        puts "Please enter valid input"
        perform_operations(category_index)
      end
    when BST_OperationCategory::SEARCH
      case inp.to_i
      when BST_Operations::SEARCH then
        NEW_BST.search_helper
        ask_for_category
      when quit_pos
        ask_for_category
      else
        puts "Please enter valid input"
        perform_operations(category_index)
      end
    when BST_OperationCategory::LOAD
      case inp.to_i
      when BST_Operations::LOAD_DATA then
        NEW_BST.load_BST_from_file_helper
        ask_for_category
      when quit_pos
        ask_for_category
      else
        puts "Please enter valid input"
        perform_operations(category_index)
      end
    end
  end

  def ask_for_category
    quit_pos=1
    for each_category in BST_CATEGORY_HASH.keys
      puts "#{each_category} #{BST_CATEGORY_HASH[each_category]}"
      quit_pos+=1
    end
    puts "#{quit_pos} For quitting"
    inp = STDIN.gets.chomp
    system("clear")
    case inp.to_i
    when BST_OperationCategory::PRINT then perform_operations(BST_OperationCategory::PRINT)
    when BST_OperationCategory::SEARCH then perform_operations(BST_OperationCategory::SEARCH)
    when BST_OperationCategory::MODIFY then perform_operations(BST_OperationCategory::MODIFY)
    when BST_OperationCategory::LOAD then perform_operations(BST_OperationCategory::LOAD)
    when quit_pos
      save_helper
      return
    else
      puts "enter valid option"
      ask_for_category
    end
  end
end

#creating an instance of BST class
# if ARGV.length>0
#   new_bs = BST.new(ARGV[0])
# else
#   new_bs = BST.new
# end
#
# while true
#   puts "HOME PAGE"
#   puts "Enter the corresponding option"
#   puts "1. Load data from external file"
#   puts "2. perform operations on BST"
#   puts "3. Quit"
#   input = STDIN.gets.chomp
#   case input
#   when "1"
#     new_bs.load_BST_from_file
#   when "2"
#     new_bs.perform_operations
#   when "3"
#     break
#   else
#     puts "enter correct options"
#   end
# end