require_relative "heap"

class Array
  def heap_sort!
    max_prc = Proc.new { |a,b| b <=> a }
        
    heap = BinaryMinHeap.new(&max_prc)
    
    # Heapify the array
    length.times do
      heap.push(self.pop)
    end
    
    # Extract max from heap and push to result
    heap.count.times do
      self.push(heap.extract)
    end

  end
end


    # (0...length).each do |new_to_heap_idx|
    #   BinaryMinHeap.heapify_up(self, new_to_heap_idx, &max_prc)
    # end    
    
    # (length - 1).downto(0) do |idx|
    #   self[0], self[idx] = self[idx], self[0]
    #   BinaryMinHeap.heapify_down(self, 0, idx, &max_prc)
    # end
    
    # self