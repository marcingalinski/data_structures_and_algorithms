def moves coordinates
	jumps = [[1, 2],[1, -2],[-1, 2],[-1, -2],[2, 1],[2, -1],[-2, 1],[-2, -1]]

	moves = jumps.map do |jump| 
		x = jump[0] + coordinates[0]
		y = jump[1] + coordinates[1]
		[x, y]
	end

	moves.select do |move| 
		(0..7).include?(move[0]) && (0..7).include?(move[1]) 
	end
end

def knight_moves(start, target, way=[])
	way << start

	if moves(start).include? target
		way << target 
	else
		moves(start).find do |move|
			puts move.inspect
			unless way.include? move
				knight_moves(move, target, way).last == target
			end
		end
	end
	way
end

fields = (0..7).to_a.product((0..7).to_a)
start = fields.sample
target = fields.sample
way = knight_moves(start,target)
puts "You've reached your target. It took #{way.size} steps: "
puts "#{way}"
