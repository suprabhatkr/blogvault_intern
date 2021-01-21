require_relative 'Node.rb'
#include Node

LL_OPERATION_HASH = Hash.new
LL_CATEGORY_HASH = Hash.new

def add_category(category_index,category_message)
  LL_OPERATION_HASH[category_index] = Hash.new
  LL_CATEGORY_HASH[category_index] = category_message
  category_index
end

def add_operation(operation_index,message,category_index)
  LL_OPERATION_HASH[category_index][operation_index]=message
  operation_index
end

module LL_OperationCategory
  PRINT = add_category(1, "Print")
  MODIFY = add_category(2, "Modify")
  SEARCH = add_category(3, "Search")
  LOAD = add_category(4,"Load Data")
end

module LL_Operations
  PRINT_DATA = add_operation(1, "Print all data of linked list",LL_OperationCategory::PRINT)
  SEARCH = add_operation(1, "Search an element by value", LL_OperationCategory::SEARCH)
  ADD_ELEMENTS = add_operation(1, "Add elements to the linked list (comma seperated)", LL_OperationCategory::MODIFY)
  DELETE = add_operation(2, "Delete an element by value", LL_OperationCategory::MODIFY)
  LOAD_DATA = add_operation(1,"Load data from external file",LL_OperationCategory::LOAD)
end

class Lindkedlist
  def initialize(args)
    @root = nil
    @tail = nil
    @filename = args
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

  def save_helper
    if @filename==nil
      puts "Enter filename to save data"
      inp = STDIN.gets.chomp
      system("clear")
      save_to_file(inp)
    else
      inp = @filename
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
    system("clear")
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
    system("clear")
    add_elements(inp)
  end

  def print_helper
    puts "All the data of linked list are"
    print_all_elements
    puts "\n"
  end

  def delete_helper
    puts "enter element to be deleted"
    inp = STDIN.gets.chomp
    system("clear")
    delete(inp.to_i)
  end

  def load_helper
    if @filename==nil
      puts "Enter filename"
      inp = STDIN.gets.chomp
      system("clear")
    else
      inp = @filename
    end
    f = File.open(inp)
    add_elements(f.read)
  end

  def perform_operations(category_index)
    quit_pos=1
    for each_operation in LL_OPERATION_HASH[category_index].keys
      puts "#{each_operation} #{LL_OPERATION_HASH[category_index][each_operation]}"
      quit_pos+=1
    end
    puts "#{quit_pos} For quitting"
    inp = STDIN.gets.chomp
    system("clear")
    case category_index
    when LL_OperationCategory::PRINT
      case inp.to_i
      when LL_Operations::PRINT_DATA then
        print_helper
        ask_for_category
      when quit_pos
        ask_for_category
      else
        puts "Please enter valid input"
        perform_operations(category_index)
      end
    when LL_OperationCategory::MODIFY
      case inp.to_i
      when LL_Operations::ADD_ELEMENTS then
        add_elements_helper
        ask_for_category
      when LL_Operations::DELETE then
        delete_helper
        ask_for_category
      when quit_pos
        ask_for_category
      else
        puts "Please enter valid input"
        perform_operations(category_index)
      end
    when LL_OperationCategory::SEARCH
      case inp.to_i
      when LL_Operations::SEARCH then
        search_helper
        ask_for_category
      when quit_pos
        ask_for_category
      else
        puts "Please enter valid input"
        perform_operations(category_index)
      end
    when LL_OperationCategory::LOAD
      case inp.to_i
      when LL_Operations::LOAD_DATA then
        load_helper(FILE_LL)
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
    for each_category in LL_CATEGORY_HASH.keys
      puts "#{each_category} #{LL_CATEGORY_HASH[each_category]}"
      quit_pos+=1
    end
    puts "#{quit_pos} For quitting"
    inp = STDIN.gets.chomp
    system("clear")
    case inp.to_i
    when LL_OperationCategory::PRINT then perform_operations(LL_OperationCategory::PRINT)
    when LL_OperationCategory::SEARCH then perform_operations(LL_OperationCategory::SEARCH)
    when LL_OperationCategory::MODIFY then perform_operations(LL_OperationCategory::MODIFY)
    when LL_OperationCategory::LOAD then perform_operations(LL_OperationCategory::LOAD)
    when quit_pos
      save_helper
      return
    else
      puts "enter valid option"
      ask_for_category
    end
  end
end