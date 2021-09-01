extends TileMap

func has_wall(position):
	var cell_pos = world_to_map(to_local(position))
	return get_cellv(cell_pos)

func eat(position):
	var cell_pos = world_to_map(to_local(position))
	if (get_cellv(cell_pos) >= 45):
		set_cell(cell_pos.x, cell_pos.y, 44)
		return true
	return false
