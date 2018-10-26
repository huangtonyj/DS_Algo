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