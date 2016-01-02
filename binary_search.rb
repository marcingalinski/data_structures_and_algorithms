class Node
	attr_reader :value
	attr_accessor(:parent, :l_child, :r_child)

	def self.build_tree(ary, parent=nil) 
		if ary.empty?
			return
		elsif ary.size == 1
			self.new(ary.first, parent)
		else
			middle = ary.size / 2
			ary_1 = ary[0...middle]
			ary_2 = ary[middle..-1]
			node = self.new(ary_2.shift, parent)
			node.l_child = ary_1.empty? ? nil : self.build_tree(ary_1, node) 
			node.r_child = ary_2.empty? ? nil : self.build_tree(ary_2, node)
			node
		end
	end

	def self.tree_from_unsorted ary
		nodes = []

		ary.each do |number|
			index = nodes.index { |node| node.value > number }

			if index
				r_child = nodes[index]
				l_child = r_child.l_child
				
				parent = r_child.parent
				new_node = self.new(number, parent)

				new_node.l_child = l_child
				new_node.r_child = r_child

				r_child.parent = new_node
				r_child.l_child = nil
				l_child.parent = new_node if l_child

				if parent
					if parent.r_child == r_child 
						parent.r_child = new_node
					else
						parent.l_child = new_node
					end
				end

				nodes.insert(index, new_node)
			else
				l_child = nodes.last
				parent = l_child.parent if l_child
				new_node = self.new(number, parent)
				new_node.l_child = l_child
				l_child.parent = new_node if l_child
				parent.r_child = new_node if parent
				nodes << new_node
			end
		end

		nodes
	end

	def initialize(value, parent)
		@value = value
		@parent = parent
	end
end

array = Array.new(80) { |i| i }
Node.tree_from_unsorted(array.shuffle).each do |node| 
	l_child_value = node.l_child.value if node.l_child
	r_child_value = node.r_child.value if node.r_child
	puts "value: #{node.value} children: #{l_child_value}, #{r_child_value}" 
end
