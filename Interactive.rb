require_relative 'BST.rb'
require_relative 'linked_list.rb'

OPERATION_HASH = Hash.new
CATEGORY_HASH = Hash.new
DS_HASH = Hash.new

NEW_LL = Lindkedlist.new
NEW_BST = BST.new

FILE_LL = ARGV[0]
FILE_BST = ARGV[1]

def add_ds(ds_index,data_structure)
  OPERATION_HASH[ds_index] = Hash.new
  DS_HASH[ds_index]=data_structure
  ds_index
end
def add_category(category_index,category_message)
  for each_ds in DS_HASH.keys
    OPERATION_HASH[each_ds][category_index] = Hash.new
  end
  CATEGORY_HASH[category_index] = category_message
  category_index
end
def add_operation(operation_index,message,category_index,ds_index)
  OPERATION_HASH[ds_index][category_index][operation_index]=message
  operation_index
end

def add_home_page_function(index,task_message)
  HOME_PAGE_HASH[index]= task_message
  index
end

module DS
  Lindkedlist = add_ds(1,"linked list")
  BST = add_ds(2,"Binary Search Tree")
end

module OperationCategory
  PRINT = add_category(1, "Print")
  MODIFY = add_category(2, "Modify")
  SEARCH = add_category(3, "Search")
  LOAD = add_category(4,"Load Data")
end

module Operations
  BST_PRINT_PATHS = add_operation(1, "Print all the paths from root to leaves",OperationCategory::PRINT,DS::BST)
  BST_SMALLEST = add_operation(2, "Print the smallest element", OperationCategory::PRINT,DS::BST)
  BST_LARGEST = add_operation(3, "Print the largest element", OperationCategory::PRINT,DS::BST)
  BST_PRE_ORDER = add_operation(4, "Print the pre order traversal", OperationCategory::PRINT,DS::BST)
  BST_POST_ORDER = add_operation(5, "Print the post order traversal", OperationCategory::PRINT,DS::BST)
  BST_IN_ORDER = add_operation(6, "Print the in order traversal", OperationCategory::PRINT,DS::BST)
  BST_LEVEL_ORDER = add_operation(7, "Print the level order traversal", OperationCategory::PRINT,DS::BST)
  BST_SEARCH = add_operation(1, "Search an element by value", OperationCategory::SEARCH,DS::BST)
  BST_ADD_ELEMENTS = add_operation(1, "Add elements to the tree (comma seperated)", OperationCategory::MODIFY,DS::BST)
  BST_DELETE = add_operation(2, "Delete an element by value", OperationCategory::MODIFY,DS::BST)
  BST_LOAD_DATA = add_operation(1,"Load data from external file",OperationCategory::LOAD,DS::BST)
  LL_PRINT_DATA = add_operation(1, "Print all data of linked list",OperationCategory::PRINT,DS::Lindkedlist)
  LL_SEARCH = add_operation(1, "Search an element by value", OperationCategory::SEARCH,DS::Lindkedlist)
  LL_ADD_ELEMENTS = add_operation(1, "Add elements to the linked list (comma seperated)", OperationCategory::MODIFY,DS::Lindkedlist)
  LL_DELETE = add_operation(2, "Delete an element by value", OperationCategory::MODIFY,DS::Lindkedlist)
  LL_LOAD_DATA = add_operation(1,"Load data from external file",OperationCategory::LOAD,DS::Lindkedlist)
end

def perform_operations(ds_index,category_index)
  quit_pos=1
  for each_operation in OPERATION_HASH[ds_index][category_index].keys
    puts "#{each_operation} #{OPERATION_HASH[ds_index][category_index][each_operation]}"
    quit_pos+=1
  end
  puts "#{quit_pos} For quitting"
  inp = STDIN.gets.chomp
  case ds_index
  when DS::Lindkedlist
    case category_index
    when OperationCategory::PRINT
      case inp.to_i
      when Operations::LL_PRINT_DATA then
        NEW_LL.print_helper
        ask_for_category(ds_index)
      when quit_pos
        ask_for_category(ds_index)
      else "Please enter valid input"
      end
    when OperationCategory::MODIFY
      case inp.to_i
      when Operations::LL_ADD_ELEMENTS then
        NEW_LL.add_elements_helper
        ask_for_category(ds_index)
      when Operations::LL_DELETE then
        NEW_LL.delete_helper
        ask_for_category(ds_index)
      when quit_pos
        ask_for_category(ds_index)
      else "Please enter valid input"
      end
    when OperationCategory::SEARCH
      case inp.to_i
      when Operations::LL_SEARCH then
        NEW_LL.search_helper
        ask_for_category(ds_index)
      when quit_pos
        ask_for_category(ds_index)
      else "Please enter valid input"
      end
    when OperationCategory::LOAD
      case inp.to_i
      when Operations::LL_LOAD_DATA then
        NEW_LL.load_helper(FILE_LL)
        ask_for_category(ds_index)
      when quit_pos
        ask_for_category(ds_index)
      else "Please enter valid input"
      end
    end
    when DS::BST
      case category_index
      when OperationCategory::PRINT
        case inp.to_i
        when Operations::BST_PRINT_PATHS then
          NEW_BST.print_path_helper
          ask_for_category(ds_index)
        when Operations::BST_IN_ORDER then
          NEW_BST.inorder_traversal_helper
          ask_for_category(ds_index)
        when Operations::BST_LEVEL_ORDER then
          NEW_BST.levelorder_traversal_helper
          ask_for_category(ds_index)
        when Operations::BST_PRE_ORDER then
          NEW_BST.preorder_traversal_helper
          ask_for_category(ds_index)
        when Operations::BST_POST_ORDER then
          NEW_BST.postorder_traversal_helper
          ask_for_category(ds_index)
        when Operations::BST_LARGEST then
          NEW_BST.largest_element_helper
          ask_for_category(ds_index)
        when Operations::BST_SMALLEST then
          NEW_BST.smallest_element_helper
          ask_for_category(ds_index)
        when quit_pos
          ask_for_category(ds_index)
        else
          "Please enter valid input"
          perform_operations(ds_index,category_index)
        end
      when OperationCategory::MODIFY
        case inp.to_i
        when Operations::BST_ADD_ELEMENTS then
          NEW_BST.add_elements_helper
          ask_for_category(ds_index)
        when Operations::BST_DELETE then
          NEW_BST.remove_helper
          ask_for_category(ds_index)
        when quit_pos
          ask_for_category(ds_index)
        else
          "Please enter valid input"
          perform_operations(ds_index,category_index)
        end
      when OperationCategory::SEARCH
        case inp.to_i
        when Operations::BST_SEARCH then
          NEW_BST.search_helper
          ask_for_category(ds_index)
        when quit_pos
          ask_for_category(ds_index)
        else
          "Please enter valid input"
          perform_operations(ds_index,category_index)
        end
      when OperationCategory::LOAD
        case inp.to_i
        when Operations::BST_LOAD_DATA then
          NEW_BST.load_BST_from_file_helper(FILE_BST)
          ask_for_category(ds_index)
        when quit_pos
          ask_for_category(ds_index)
        else
          "Please enter valid input"
          perform_operations(ds_index,category_index)
        end
      end
    end
end

def ask_for_category(ds_index)
  quit_pos=1
  for each_category in CATEGORY_HASH.keys
    puts "#{each_category} #{CATEGORY_HASH[each_category]}"
    quit_pos+=1
  end
  puts "#{quit_pos} For quitting"
  inp = STDIN.gets.chomp
  case inp.to_i
  when OperationCategory::PRINT then perform_operations(ds_index,OperationCategory::PRINT)
  when OperationCategory::SEARCH then perform_operations(ds_index,OperationCategory::SEARCH)
  when OperationCategory::MODIFY then perform_operations(ds_index,OperationCategory::MODIFY)
  when OperationCategory::LOAD then perform_operations(ds_index,OperationCategory::LOAD)
  when quit_pos
    case ds_index
    when DS::Lindkedlist then NEW_LL.save_helper(FILE_LL)
    when DS::BST then NEW_BST.save_helper(FILE_BST)
    end
    home
  else
    puts "enter valid option"
    ask_for_category(ds_index)
  end
end

def home
  quit_pos = 1
  for each_ds in DS_HASH.keys
    puts "#{each_ds} Perfrom operations on #{DS_HASH[each_ds]}"
    quit_pos+=1
  end
  puts "#{quit_pos} For quitting"
  inp = STDIN.gets.chomp
  case inp.to_i
  when DS::Lindkedlist then
    ask_for_category(DS::Lindkedlist)
  when DS::BST then
    ask_for_category(DS::BST)
  when quit_pos
    puts "Bye"
  else "Please enter valid option"
  end
end

home

