# QuickSort

---
## Algorithm review

Using `n` additional space
* Pick a pivot element
* Make a sub-array of all the elements less than the pivot_el
* Make a sub-array of all the elements greater than the pivot_el
* Join the recursive sort of L with pivot_el with recursive sort of R
* Base case of `return arr if arr.empty?`
* Average case is `O(nlogn)`, worst case is `O(n^2)`, why?

---

```ruby
# Not in-place. Uses O(n) memory.
def self.sort1(array)
  return array if array.empty?

  # Shuffle up the pivot, why?
  new_pivot = rand(array.length)
  array[0], array[new_pivot] = array[new_pivot], array[0]

  pivot = array.first

  left = array.select { |el| pivot > el }
  middle = array.select { |el| pivot == el }
  right = array.select { |el| pivot < el }

  sort1(left) + middle + sort1(right)
end
```
---
## In-place version
* Rather than making new sub-arrays, we will rely on a partition method that is passed the whole array (along with bounds), and rearranges a subset of elements around a pivot_el (which can be randomized)

---
* The partition method returns the index at which the pivot element ended up so that we can make recursive calls to our sort! method with updated bounds, reflecting where the relatively sorted portions of the entire array lie.
* Base case of `return array if length < 2` because one element is already sorted relative to itself.

---
### Partition

```ruby
def self.partition(array, start, length, &prc)
  prc ||= Proc.new { |el1, el2| el1 <=> el2 }

  # To reduce probability of pathologically bad data set, shuffle pivot.
  new_pivot = start + rand(length)
  array[start], array[new_pivot] = array[new_pivot], array[start]

  pivot_idx = start
  pivot = array[start]

  # This is the important part that swaps elements around a pivot_idx
  ((start + 1)...(start + length)).each do |idx|
    if prc.call(pivot, array[idx]) > 0
      array[idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[idx]
      pivot_idx += 1
    end
  end

  # Moving the pivot element to its proper place
  array[start], array[pivot_idx] = array[pivot_idx], array[start]
  pivot_idx
end
```
---
### Sort!

```ruby
# In-place. Uses O(log(n)) space for recursion.
def self.sort2!(array, start = 0, length = array.length, &prc)
  prc ||= Proc.new { |el1, el2| el1 <=> el2 }

  return array if length < 2

  pivot_idx = partition(array, start, length, &prc)

  left_length = pivot_idx - start
  right_length = length - (left_length + 1)
  sort2!(array, start, left_length, &prc)
  sort2!(array, pivot_idx + 1, right_length, &prc)

  array
end
```

---
## Mock Interview Question 1

Partner A: Describe how the QuickSort in-place works. Do not look at your notes.

Parnter B: Discuss the time and space complexity of the QuickSort! method, including partition. Do not look at your notes.

---
## Mock Interview Question 2

### QuickSelect
Write an in-place instance method on the Array class that will find the `kth` smallest element in `O(n)` time. You will likely want to use a partition method similar to if not exactly the same as that which you used for QuickSort! For a bonus, how can we eliminate any extra space cost?

NB: 1st smallest is the 0-th element in a sorted array.

---

```ruby
class Array

  # This method is exactly the same.
  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    # To reduce probability of pathologically bad data set, shuffle pivot.
    new_pivot = start + rand(length)
    array[start], array[new_pivot] = array[new_pivot], array[start]

    pivot_idx = start
    pivot = array[start]

    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        array[idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[idx]
        pivot_idx += 1
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end

  def select_kth_smallest(k)
    left = 0
    right = self.length - 1
    while true
      return self[left] if left == right
      pivot_idx = Array.partition(self, left, right-left+1)
      if k-1 == pivot_idx
        return self[k-1]
      elsif k-1 < pivot_idx
        right = pivot_idx - 1
      else
        left = pivot_idx + 1
      end
    end
  end
end
```

---
### A discussion of time complexity

First let's review why QuickSort is `O(nlogn)`

* we consider each element the number of times it takes to reach a single element by recursively splitting our set in half(ish).

* `n` elements times `logn`

---
So, why is QuickSelect `O(n)`?

thoughts?

---
* Take note that each time we cut our set in half, we already know the part in which our desired element lies, based on the size of the partitions.

* Thus, each time we consider fewer and fewer elements. How many?

---
The first time we consider `n` elements.
Then, `n/2`, `n/4`...`1`

Adding these all together, we get
something called a Geometric Series, since `1, 1/2, 1/4...` can be seen as increasing powers of `1/2`

---
The sum of an convergent infinite geometric series (where the multiplicative factor, `r` is less than 1) can be found with the formula `a/(1-r)`, where a is the first term.

Without being fully rigorous about the variations of partition size, we can nevertheless see that if `r = 1/2` this comes out to `2n`, and since our series is not in fact infinite, `O(QuickSelect) < 2n ~ n`
