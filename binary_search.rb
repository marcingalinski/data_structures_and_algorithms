class Node
	attr_reader :value
	attr_accessor(:parent, :l_child, :r_child)

	def self.build_tree ary
		return if ary.empty?
		root = self.new ary.pop 
		ary.each do |number|
			self.place_node(number, root)
		end
		root
	end

	def initialize(value, parent=nil)
		@value = value
		@parent = parent
	end

	private

	def self.place_node(number, parent_node)
		if parent_node.value > number
			if parent_node.l_child
				self.place_node(number, parent_node.l_child)
			else
				new_node = self.new(number, parent_node)
				parent_node.l_child = new_node
			end
		else
			if parent_node.r_child
				self.place_node(number, parent_node.r_child)
			else
				new_node = self.new(number, parent_node)
				parent_node.r_child = new_node
			end
		end
	end
end

def breadth_first_search(target, root)
	queue = [root]

	while current = queue.shift
		return current if current.value == target
		queue << current.l_child if current.l_child
		queue << current.r_child if current.r_child 
	end
end

def depth_first_search(target, root)
	stack = [root]
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

def dfs_rec(target, current)
	result = current if current.value == target
	result ||= dfs_rec(target, current.l_child) if current.l_child
	result ||= dfs_rec(target, current.r_child) if current.r_child
	result
end

array = Array.new(50) { |i| i }
root = Node.build_tree array.shuffle
node = dfs_rec(array.sample, root)
puts "#{node} parent: #{node.parent} children: #{node.l_child} #{node.r_child}"
