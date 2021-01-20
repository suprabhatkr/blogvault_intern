require_relative 'Node.rb'

module Tree_methods
  #method to print all the data in inorder way
  def inorder_traversal(root=@root)
    if root.left!=nil
      inorder_traversal(root.left)
    end
    print root.data
    print " "
    if root.right!=nil
      inorder_traversal(root.right)
    end
  end

  #method to print all the data in preorder way
  def preorder_traversal(root=@root)
    print root.data
    print " "
    if root.left!=nil
      preorder_traversal(root.left)
    end
    if root.right!=nil
      preorder_traversal(root.right)
    end
  end

  #method to print all the data in postorder way
  def postorder_traversal(root=@root)
    if root.left!=nil
      postorder_traversal(root.left)
    end
    if root.right!=nil
      postorder_traversal(root.right)
    end
    print root.data
    print " "
  end

  #method to print all the data in level order way
  def levelorder_traversal(root=@root)
    buffer_arr = Array.new
    buffer_arr.append(root)
    curr_ind = 0
    while curr_ind<buffer_arr.length
      curr_node = buffer_arr[curr_ind]
      print "#{curr_node.data} "
      if curr_node.left != nil
        buffer_arr.append(curr_node.left)
      end
      if curr_node.right != nil
        buffer_arr.append(curr_node.right)
      end
      curr_ind+=1
    end
    buffer_arr.clear
  end
end
