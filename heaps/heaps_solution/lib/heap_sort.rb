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