class BinaryMinHeap
  attr_reader :store

  def initialize(&prc)
    @prc ||= Proc.new {|a,b| a <=> b}
    @store = []
  end

  def count
    @store.length
  end

  def peek
    @store[0]
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, &@prc)
    val
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1, &@prc)
  end

  public  
  
  def self.child_indices(len, parent_index)
    child_indices = [
      (parent_index * 2) + 1,
      (parent_index * 2) + 2
    ]
    
    child_indices.pop if child_indices.last >= len
    child_indices.pop if child_indices.last >= len
    
    child_indices
  end
  
  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) /2
  end
  
  def self.heapify_down(array, parent_idx, &prc)
    prc ||= Proc.new {|a,b| a <=> b}
    
    child_indices = self.child_indices(array.length, parent_idx)

    case child_indices.length
      when 0
        return array
      when 1
        smallest_child_idx = child_indices[0]
      when 2
        child_0_idx = array[child_indices[0]]
        child_1_idx = array[child_indices[1]]
        if prc.call(child_0_idx, child_1_idx) <0
          smallest_child_idx = child_indices[0]
        else
          smallest_child_idx = child_indices[1]
        end
    end
    
    smallest_child_val = array[smallest_child_idx]
    parent_val = array[parent_idx]
    
    if prc.call(smallest_child_val, parent_val) < 0
      array[smallest_child_idx], array[parent_idx] = array[parent_idx], array[smallest_child_idx]
    end

    self.heapify_down(array, smallest_child_idx, &prc)
  end
  
  def self.heapify_up(array, child_idx, &prc)
    prc ||= Proc.new {|a, b| a <=> b}
    
    return array if child_idx == 0
    
    parent_idx = self.parent_index(child_idx)
    
    child_val, parent_val = array[child_idx], array[parent_idx]
    
    if prc.call(child_val, parent_val) < 0
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
    end
    
    self.heapify_up(array, parent_idx, &prc)
  end
  
end

#        0
#      /  \
#     1   2
#    /\   /\
#   3 4  5 __

# 0: 1, 2
# 1: 3, 4
# 2: 5, __

# [0, 1, 2, 3, 4, 5]