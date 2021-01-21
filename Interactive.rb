require_relative 'BST.rb'
require_relative 'linked_list.rb'

FILE_LL = ARGV[0]
FILE_BST = ARGV[1]

DS_HASH = Hash.new

NEW_LL = Lindkedlist.new(FILE_LL)
NEW_BST = BST.new(FILE_BST)


def add_ds(ds_index,data_structure)
  DS_HASH[ds_index]=data_structure
  ds_index
end

module DS
  Lindkedlist = add_ds(1,"linked list")
  BST = add_ds(2,"Binary Search Tree")
end

def home
  quit_pos = 1
  for each_ds in DS_HASH.keys
    puts "#{each_ds} Perfrom operations on #{DS_HASH[each_ds]}"
    quit_pos+=1
  end
  puts "#{quit_pos} For quitting"
  inp = STDIN.gets.chomp
  system("clear")
  case inp.to_i
  when DS::Lindkedlist then
    NEW_LL.ask_for_category
    home
  when DS::BST then
    NEW_BST.ask_for_category
    home
  when quit_pos
    puts "Bye"
  else "Please enter valid option"
  end
end

home

