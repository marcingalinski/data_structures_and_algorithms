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

array = Array.new(80) { |i| i }
Node.build_tree array.shuffle
