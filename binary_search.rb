class Node
	attr_reader :value
	attr_accessor(:parent, :children)

	def self.build_tree(ary, parent=nil) 
		if ary.empty?
			return
		elsif ary.size == 1
			self.new(ary.first, parent)
		else
			middle = (ary.size / 2) + 1
			ary_1 = ary[0...middle]
			ary_2 = ary[middle..-1]
			node = self.new(ary_1.pop, parent)
			node.children << self.build_tree(ary_1, node) unless ary_1.empty?
			node.children << self.build_tree(ary_2, node) unless ary_2.empty?
			node
		end
	end

	def initialize(value, parent)
		@value = value
		@parent = parent
		@children = []
	end
end
