class Node
	attr_reader :value
	attr_accessor(:parent, :l_child, :r_child)

	def initialize(value, parent=nil)
		@value = value
		@parent = parent
	end
end

class Tree < Node
	def initialize(ary)
		root = build_tree(ary)
		@parent = nil
		@value = root.value
		@l_child = root.l_child
		@r_child = root.r_child
	end

	def breadth_first_search target
		queue = [self]

		while current = queue.shift
			return current if current.value == target
			queue << current.l_child if current.l_child
			queue << current.r_child if current.r_child 
		end
	end

	def depth_first_search target
		stack = [self]
		checked = []

		while current = stack.last
			return current if current.value == target
			checked << current
			if current.l_child && !checked.include?(current.l_child)
				stack << current.l_child
			elsif current.r_child && !checked.include?(current.r_child)
				stack << current.r_child
			else
				stack.pop
			end
		end
	end

	def dfs_rec(target, current=self)
		result = current if current.value == target
		result ||= dfs_rec(target, current.l_child) if current.l_child
		result ||= dfs_rec(target, current.r_child) if current.r_child
		result
	end

	private

	def build_tree ary
		return if ary.empty?
		root = Node.new ary.pop 
		ary.each do |number|
			place_node(number, root)
		end
		root
	end

	def place_node(number, parent_node)
		if parent_node.value > number
			if parent_node.l_child
				place_node(number, parent_node.l_child)
			else
				new_node = Node.new(number, parent_node)
				parent_node.l_child = new_node
			end
		else
			if parent_node.r_child
				place_node(number, parent_node.r_child)
			else
				new_node = Node.new(number, parent_node)
				parent_node.r_child = new_node
			end
		end
	end
end

array = Array.new(50) { |i| i }
tree = Tree.new array.shuffle
puts tree.breadth_first_search(array.sample)
puts tree.depth_first_search(array.sample)
puts tree.dfs_rec(array.sample)
