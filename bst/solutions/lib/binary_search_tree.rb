elrequire 'bst_node'
require 'byebug'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if tree_node.value == value

    (value < tree_node.value) ? find(value, tree_node.left) : find(value, tree_node.right)
  end

  def maximum(tree_node = @root)
    tree_node.right ? maximum(tree_node.right) : tree_node
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?
      
    1 + [depth(tree_node.left) + depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    return false if (depth(tree_node.left) - depth(tree_node.right)).abs > 1
  
    is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
  end
  
  def in_order_traversal(tree_node = @root, arr = [])
    # left children, itself, right children
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr) if tree_node.right

    arr
  end

  def insert(value)
    # setting the root here in case it is still nil
    @root = insert_into_tree(@root, value)
  end

  def delete(value)
    @root = delete_from_tree(@root, value)
  end


  private

  def insert_into_tree(tree_node, value)
    return BSTNode.new(value) if tree_node.nil?

    if value <= tree_node.value
      tree_node.left = insert_into_tree(tree_node.left, value)
    elsif value > tree_node.value
      tree_node.right = insert_into_tree(tree_node.right, value)
    end

    tree_node
  end

  def delete_from_tree(tree_node, value)
    # if correct node is found, then call remove on it.
    # otherwise, recurse until you find it
    if value == tree_node.value
      tree_node = remove(tree_node)
    elsif value <= tree_node.value
      tree_node.left = delete_from_tree(tree_node.left, value)
    else value > tree_node.value
      tree_node.right = delete_from_tree(tree_node.right, value)
    end
    tree_node
  end

  def remove(node)
    if node.left.nil? && node.right.nil?
      # when node doesn't have children,
      # simply remove it.
      node = nil
    elsif node.left && node.right.nil?
      # when node only has one child,
      # delete it and promote its child to take its place.
      node = node.left
    elsif node.left.nil? && node.right
      node = node.right
    else
      # if node has two children,
      # promote the maximum node in its left subtree to replace itself
      # if that specific node that was promoted has children,
      # then promote
      node = replace_parent(node)
    end
    node
  end

  def replace_parent(node)
    replacement_node = maximum(node.left)
    if replacement_node.left
      promote_child(node.left)
    end

    # since the replacement_node is still pointing to its old children,
    # we have to update its children pointers
    replacement_node.left = node.left
    replacement_node.right = node.right

    replacement_node
  end

  def promote_child(tree_node)
    if tree_node.right
      parent = tree_node
      child = tree_node.right

      while child.right
        parent = parent.right
        child = child.right
      end

      parent.right = child.left
    end
  end
end
