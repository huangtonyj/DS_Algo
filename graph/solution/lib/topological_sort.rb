require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  in_edge_counts = {}
  queue = []

  vertices.each do |v|
    in_edge_counts[v] = v.in_edges.count
    queue << v if v.in_edges.empty?
  end

  sorted_vertices = []

  until queue.empty?
    vertex = queue.shift
    sorted_vertices << vertex

    vertex.out_edges.each do |e|
      to_vertex = e.to_vertex

      in_edge_counts[to_vertex] -= 1
      queue << to_vertex if in_edge_counts[to_vertex] == 0
    end
  end

  return [] if sorted_vertices.length != vertices.length
  sorted_vertices
end




# def topological_sort(vertices)
#   order = []
#   explored = Set.new
#   temp = Set.new
#   cycle = false

#   vertices.each do |vertex|
#     cycle = dfs!(vertex, explored, temp, order, cycle)  unless explored.include?(vertex)
#     return [] if cycle
#   end

#   order
# end


# def dfs!(vertex, explored, temp, order, cycle)
#   return true if temp.include?(vertex)
#   temp.add(vertex)

#   vertex.out_edges.each do |edge|
#     next_vertex = edge.to_vertex
#     cycle = dfs!(next_vertex, explored, temp, order, cycle) unless explored.include?(next_vertex)
#     return true if cycle
#   end

#   explored.add(vertex)
#   temp.delete(vertex)
#   order.unshift(vertex)
#   false
# end