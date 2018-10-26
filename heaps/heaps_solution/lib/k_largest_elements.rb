require_relative 'heap'

def k_largest_elements(array, k)
  
  heap = BinaryMinHeap.new
  
  k.times { |idx| heap.push array[idx] }
  
  (k...array.length).each do |idx|
    heap.push(array[idx])
    heap.extract
  end
  
  result = []
  
  k.times { result.push heap.extract }
  
  result
end

# max_prc = Proc.new { |a,b| b <=> a }

# # Heapify the array
# (k...array.length).each do |new_to_heap_idx|
#   BinaryMinHeap.heapify_up(array, new_to_heap_idx, &max_prc)
# end

# # Take out max, aka first one, update heap with heapify down.
# (array.length - 1).downto(k) do |idx|
#   array[0], array[idx] = array[idx], array[0]
#   BinaryMinHeap.heapify_down(array, 0, idx, &max_prc)
# end

# array[-k..-1]